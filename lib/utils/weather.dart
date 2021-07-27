import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:weatherapp/constants.dart';
import 'package:weatherapp/credentials.dart';
import 'package:weatherapp/utils/location.dart';

//Setting icon and background image
class WeatherDisplayData{
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

//Request weather from the API on lat/long
class WeatherData{
  WeatherData({required this.locationData});
  LocationHelper locationData;

  double currentTemp = 0.0;
  double currentTempMin = 0.0;
  double currentTempMax = 0.0;
  double currentWindSpeed = 0.0;

  String currentDescription = "";
  String currentLocation = "";
  String currentCountry = "";

  int currentCon = 0;
  int currentHumidity = 0;

  //Future settings switch
  String appLang = "en";
  String appUnits = "metric";

  Future<void> getCurrentTemperature() async{
    Response response = await get(
      //One call API. Returns more data than the standard data
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=${locationData.latitude}&lon=${locationData.longitude}&exclude=&appid=${apiKey}&units=${appUnits}&lang=${appLang}'
        )
    );

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
        currentCon = currentWeather['current']['weather']['id'];
        currentHumidity = currentWeather['current']['humidity'];
      }catch(e){
        print("Exception: $e");
      }
    }else{
      print('Error: Unable to fetch weather data');
    }
  }

  //Icon changing based on weather
  //To Do: Maybe update into switch statement and take into account more conditions (Sun + Cloud, Snow, Fog)
  //Kinda crazy? How about splitting background. Making a dayscape and nightscape, then if cloudy we add more to sky? Madness
  WeatherDisplayData getWeatherDisplayData(){
    if(currentCon < 600){
      return WeatherDisplayData(
        weatherIcon: kCloudIcon,
        weatherImage: AssetImage('assets/backgroundnight.png'),
      );
    }else{
      var currentTime = new DateTime.now();
      if(currentTime.hour >= 19){
        return WeatherDisplayData(
          weatherIcon: kMoonIcon,
          weatherImage: AssetImage('assets/backgroundnight.png'),
          );
      }else{
        return WeatherDisplayData(
          weatherIcon: kSunIcon,
          weatherImage: AssetImage('assets/backgroundday.png'),
        );
      }
    }
  }
}