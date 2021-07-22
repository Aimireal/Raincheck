import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherapp/constants.dart';

import 'package:weatherapp/screens/main_display.dart';
import 'package:weatherapp/utils/location.dart';
import 'package:weatherapp/utils/weather.dart';


class LoadingScreen extends StatefulWidget{
  @override 
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>{
  late LocationHelper locationData;

  Future<void> getLocationData() async{
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if(locationData.latitude == null || locationData.longitude == null){
      //Error handle no location value

    }
  }

  void getWeatherData() async{
    //Get location
    await getLocationData();

    //Get weather
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if(weatherData.currentTemp == null || weatherData.currentCon == null){
      //Error handle no weather
    }

    //Open main display
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context){
          return MainDisplay(
            weatherData: weatherData
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(File('assets/loadingbackground.png')),
          ),
        ),
        child: Center(
          child: SpinKitCircle(
            color: Colors.white,
            size: 150.0,
            duration: Duration(milliseconds: 1500),
            ),
          ),
        )
      );
    }
  }

