import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weatherapp/constants.dart';
import 'package:weatherapp/credentials.dart';
import 'package:weatherapp/utils/location.dart';


class WeatherDisplayData{
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData{
  WeatherData({required this.locationData});
  LocationHelper locationData;

  double currentTemp = 0;
  int currentCon = 0;

  Future<void> getCurrentTemperature() async {
   
    Response response = await get(
      Uri.parse('http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric')
    );

    //Retreive the JSON data for weather
    if(response.statusCode == 200){
      String data = response.body;
      var currentWeather = jsonDecode(data);
      try{
        currentTemp = currentWeather['main']['temp'];
        currentCon = currentWeather['weather'][0]['id'];
      }catch(e){
        print("Exception: $e");
      }
    }else{
      print('Error: Unable to fetch weather data');
    }
  }

  WeatherDisplayData getWeatherDisplayData(){
    if(currentCon < 600){
      return WeatherDisplayData(
        weatherIcon: kCloudIcon,
        weatherImage: AssetImage('assets/weatherbackground.jpg'),
      );
    }else{
      var currentTime = new DateTime.now();
      if(currentTime.hour >= 17){
        return WeatherDisplayData(
          weatherIcon: kMoonIcon,
          weatherImage: AssetImage('assets/weatherbackground.jpg'),
          );
      }else{
        return WeatherDisplayData(
          weatherIcon: kSunIcon,
          weatherImage: AssetImage('assets/weatherbackground.jpg'),
        );
      }
    }
  }
}