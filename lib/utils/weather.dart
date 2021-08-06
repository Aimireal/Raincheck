import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:weatherapp/constants.dart';
import 'package:weatherapp/credentials.dart';
import 'package:weatherapp/utils/location.dart';
import 'package:weatherapp/utils/dailyweather.dart';

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

  //List for daily/hourly cards
  List<DailyWeather> dailyWeatherCards = [];
  //List<HourlyWeather> hourlyWeathercards = [];

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
        currentCon = currentWeather['current']['weather'][0]['id'];
        currentHumidity = currentWeather['current']['humidity'];
      }catch(e){
        print("Exception: $e");
      }
    }else{
      print('Error: Unable to fetch weather data');
    }
  }

  //Daily weather values - Check against inspiration later since changed function a lot
  void getDailyWeather(dynamic response){
    List<dynamic> jsonDays = response['daily'];
    jsonDays.forEach((day){
      dailyWeatherCards.add(
        DailyWeather(
          weekday: kWeekdays.toString()[
              DateTime.fromMillisecondsSinceEpoch(day['dt'] * 1000).weekday],
          conditionWeather: day['weather'][0]['id'],
          maxTemp: day['temp']['max'].round(),
          minTemp: day['temp']['min'].round(),
        ),
      );
    });
    print('Daily MaxTemp: $maxTemp - MinTemp: $minTemp');
  }

  //Icon changing based on weather
  WeatherDisplayData getWeatherDisplayData(){
    var dayNight;
    var clearIcon;
    var currentTime = new DateTime.now();

    //Set background to day or night version
    if(currentTime.hour >= 19){
      dayNight = AssetImage('assets/backgroundnight.png');
      clearIcon = kMoonIcon;
    } else{
      dayNight = AssetImage('assets/backgroundday.png');
      clearIcon = kSunIcon;
    }

    /*
    switch(currentCon){
      case 'Thunderstorm':
        return WeatherDisplayData(
        weatherIcon: kLightningIcon,
        weatherImage: dayNight,
      );
      case 'Drizzle':
        return WeatherDisplayData(
        weatherIcon: kDrizzleIcon,
        weatherImage: dayNight,
      );
      case 'Rain':
        return WeatherDisplayData(
        weatherIcon: kRainIcon,
        weatherImage: dayNight,
      );
      case 'Snow':
        return WeatherDisplayData(
        weatherIcon: kSnowIcon,
        weatherImage: dayNight,
      );
      case 'Clear':
        return WeatherDisplayData(
        weatherIcon: clearIcon,
        weatherImage: dayNight,
      );
      case 'Clouds':
        return WeatherDisplayData(
        weatherIcon: kCloudIcon,
        weatherImage: dayNight,
      );
      default: 
        return WeatherDisplayData(
        weatherIcon: kErrorIcon,
        weatherImage: dayNight,
      );
    }
    */
     
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