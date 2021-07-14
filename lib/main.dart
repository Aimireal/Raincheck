import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'widgets/main_widget.dart';

import 'dart:async';
import 'dart:convert';

//Passing in data to the API
Future<WeatherInfo> fetchWeather() async{
  final zipCode = "BD2";
  final countryCode = "GB";
  final apiKey = "3159cf0581c711d50d2731117f37620a";
  final requestUrl = "http://api.openweathermap.org/data/2.5/weather?zip=${zipCode},${countryCode}&units=metric&appid=${apiKey}";

  final response = await http.get(Uri.parse(requestUrl));

  if(response.statusCode == 200){
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error loading request URL info");
  }
}

//Initialising data values for display later
class WeatherInfo{
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  WeatherInfo({
    @required this.location,
    @required this.temp,
    @required this.tempMin,
    @required this.tempMax,
    @required this.weather,
    @required this.humidity,
    @required this.windSpeed
  });

  //Getting relevant values from the API's JSON
  factory WeatherInfo.fromJson(Map<String, dynamic> json){
    return WeatherInfo(
      location: json['name'],
      temp: json['main']['temp'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      weather: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed']
    );
  }
}

//Running the application
void main() => runApp(
  MaterialApp(
    title: "Weather",
    home: MyApp()
  )
);

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState (){
    return _MyApp();
  }
}

class _MyApp extends State<MyApp>{

late Future<WeatherInfo> futureWeather;

@override
void initState(){
  super.initState();
  futureWeather = fetchWeather();
}

  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: FutureBuilder<WeatherInfo>(
        future: futureWeather,
        builder: (context, snapshot){
          if(snapshot.hasData){
              return MainWidget(
                location: snapshot.data!.location,
                temp: snapshot.data!.temp,
                tempMin: snapshot.data!.tempMin,
                tempMax: snapshot.data!.tempMax,
                weather: snapshot.data!.weather,
                humidity: snapshot.data!.humidity,
                windSpeed: snapshot.data!.windSpeed
              );
          }else if(snapshot.hasError){
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return CircularProgressIndicator();
        }
      )
    );
  }
}