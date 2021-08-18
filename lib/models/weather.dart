import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:weatherapp/constants.dart';
import 'package:weatherapp/credentials.dart';
import 'package:weatherapp/models/dailyweather.dart';
import 'package:weatherapp/utils/location.dart';
import 'package:weatherapp/utils/daynight.dart';
import 'package:weatherapp/utils/network.dart';
import 'package:weatherapp/widgets/daily_weather_display.dart';

//Setting icon and background image
class WeatherDisplayData{
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({ required this.weatherIcon,  required this.weatherImage});
}

//Request weather from the API on lat/long
class WeatherData{
  WeatherData({ required this.locationData});
  LocationHelper locationData;

  //List for daily/hourly cards
  List<DailyWeather> dailyWeatherCards = [];

  //Current weather values
  double currentTemp = 0.0;
  double currentTempMin = 0.0;
  double currentTempMax = 0.0;
  double currentWindSpeed = 0.0;

  String currentDescription = "";
  String currentLocation = "";
  String currentCountry = "";

  int currentCon = 0;
  int currentHumidity = 0;

  //Daily weather values
  dynamic maxTemp;
  dynamic minTemp;
  dynamic weatherResponse;

  Future<void> getCurrentTemperature() async{
    Response response = await
      NetworkService().getCurrentTemperature(locationData);

    weatherResponse = response;

    //Return the weather values
    if(response.statusCode == 200){
      String data = response.body;
      var currentWeather = jsonDecode(data);
      try{
        currentTemp = currentWeather['current']['temp'];
        currentTempMin = currentWeather['daily'][0]['temp']['min'];
        currentTempMax = currentWeather['daily'][0]['temp']['max'];
        currentWindSpeed = currentWeather['current']['wind_speed'];
        currentDescription = currentWeather['current']['weather'][0]['description'];
        currentCon = currentWeather['current']['weather'][0]['id'];
        currentHumidity = currentWeather['current']['humidity'];
      }catch(e){
        print("Exception: $e");
      }
    }else{
      print('Error: Unable to fetch weather data');
    }
  }

  //Generating a DailyWeather instance for daily weather cards
  //ToDo: I wonder if it doesn't work since I use weatherData, instead of the response object
  void getDailyWeather(weatherResponse) {
    List<dynamic> jsonDays = weatherResponse['daily'];
    jsonDays.forEach((day) {
      dailyWeatherCards.add(
        DailyWeather(
          weekday: kWeekdays[
              DateTime.fromMillisecondsSinceEpoch(day['dt'] * 1000).weekday]?? '',
          //conditionWeather: day['weather'][0]['id'],
          maxTemp:
              day['temp']['max'].round(),
          minTemp: day['temp']['min'].round(),
        ),
      );
    });
  }

  //Icon changing based on weather
  WeatherDisplayData getWeatherDisplayData(){
    var clearIcon;
    var currentTime = new DateTime.now();

    //Set background to day or night version
    if(currentTime.hour >= 19){
      clearIcon = kMoonIcon;
    } else{
      clearIcon = kSunIcon;
    }

    var dayNight = DayNight().backgroundChanger();
     
    //Check conditions from API to decide icon
    if(currentCon >= 200 && currentCon < 300){
      return WeatherDisplayData(
        weatherIcon: kLightningIcon,
        weatherImage: dayNight,
      );
    } else if(currentCon >= 300 && currentCon < 400){
      return WeatherDisplayData(
        weatherIcon: kDrizzleIcon,
        weatherImage: dayNight,
      );
    } else if(currentCon >= 500 && currentCon < 600){
      return WeatherDisplayData(
        weatherIcon: kRainIcon,
        weatherImage: dayNight,
      );
    } else if (currentCon >= 600 && currentCon < 700){
      return WeatherDisplayData(
        weatherIcon: kSnowIcon,
        weatherImage: dayNight,
      );
    } else if (currentCon >= 701 && currentCon < 800){
      return WeatherDisplayData(
        weatherIcon: kAtmosphereIcon,
        weatherImage: dayNight,
      );
    } else if (currentCon == 800){
      return WeatherDisplayData(
        weatherIcon: clearIcon,
        weatherImage: dayNight,
      );
    } else if (currentCon >= 801 && currentCon <= 804){
      return WeatherDisplayData(
        weatherIcon: kCloudIcon,
        weatherImage: dayNight,
      );
    } else{
      return WeatherDisplayData(
        weatherIcon: kErrorIcon,
        weatherImage: dayNight,
      );
    }
  }
}