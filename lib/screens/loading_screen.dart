import 'package:flutter/material.dart';

import 'package:weatherapp/screens/main_display.dart';
import 'package:weatherapp/utils/location.dart';
import 'package:weatherapp/utils/weather.dart';
import 'package:weatherapp/utils/geocoding.dart';


class LoadingScreen extends StatefulWidget{
  @override 
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>{
  late LocationHelper locationData;

  //Retrieve user lat/long values
  Future<void> getLocationData() async{
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    var latitude = locationData.latitude;
    var longitude = locationData.longitude;

    if(latitude == null || longitude == null){
      //Error handle no location value
      print('Error: Latitude = $latitude | Longitude = $longitude');
    }
  }

  void getWeatherData() async{
    await getLocationData();

    //Get weather
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    var currentTemp = weatherData.currentTemp;
    var currentCon = weatherData.currentCon;

    if(weatherData.currentTemp == null || weatherData.currentCon == null){
      print('Error: Temp: $currentTemp | Con: $currentCon');
    }

    //GetLocation
    GeoData geoData = GeoData(locationData: locationData);
    await geoData.getGeolocationData();

    var currentCity = geoData.currentCity;
    var currentCountry = geoData.currentCountry;

    if(currentCity == null || currentCountry == null){
      print('Error: City: $currentCity | Country: $currentCountry');
    }

    //Open main display
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context){
          return MainDisplay(
            weatherData: weatherData,
            geoData: geoData
          );
        },
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    getWeatherData();
  }

  @override 
  Widget build(BuildContext buildContext){
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/loadingbackground.png'),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      )
    );
  }
}