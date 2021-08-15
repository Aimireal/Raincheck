import 'package:flutter/material.dart';

import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/utils/geocoding.dart';
import 'package:weatherapp/utils/string_formatter.dart';
import 'package:weatherapp/widgets/weather_display.dart';
import 'package:weatherapp/models/dailyweather.dart';
import 'package:weatherapp/widgets/daily_weather_display.dart';

class MainDisplay extends StatefulWidget {
  //Initialise a WeatherData object to retreive data from the OpenWeatherMaps API
  MainDisplay({required this.weatherData, required this.geoData});

  final WeatherData weatherData;
  final GeoData geoData;

  @override
  _MainDisplayState createState() => _MainDisplayState();
}

class _MainDisplayState extends State<MainDisplay> {
  //Taking values from the WeatherData object for display
  late int temperature;
  late int tempMin;
  late int tempMax;
  late int humidity;
  late int windSpeed;

   //Added temp values for strings
  late String weatherDesc = "";
  late String locationName = "";
  late String countryName = "";

  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;

  void updateDisplayInfo(WeatherData weatherData, GeoData geoData) {
    setState(() {
      temperature = weatherData.currentTemp.round();
      tempMin = weatherData.currentTempMin.round();
      tempMax = weatherData.currentTempMax.round();
      humidity = weatherData.currentHumidity.round();
      windSpeed = weatherData.currentWindSpeed.round();

      //Apply capitalise function from string_formatter
      weatherDesc = weatherData.currentDescription.capitalise();
      locationName = geoData.currentCity.capitalise();
      countryName = geoData.currentCountry;

      //Dynamic icon/background
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    super.initState();
    updateDisplayInfo(widget.weatherData, widget.geoData);
  }

  //Build interface
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: <Widget>[
        Center(
          //Main Weather Display
          child: Weather_Display(
            backgroundImage: backgroundImage, 
            weatherDisplayIcon: weatherDisplayIcon, 
            temperature: temperature, 
            locationName: locationName, 
            countryName: countryName, 
            weatherDesc: weatherDesc, 
            tempMin: tempMin, 
            tempMax: tempMax, 
            humidity: humidity, 
            windSpeed: windSpeed,
          ),
        ),
        Center(
          /*
          ListView.builder(
            itemCount: WeatherData.dailyWeatherCards.length,
            itemBuilder: (context, index){
              //Daily cards
              return DailyWeatherCard(
                weekday: WeatherData.dailyWeatherCards[index].weekday,
                weatherCondition: WeatherData.dailyWeatherCards[index].conditionWeather,
                maxTemp: WeatherData.dailyWeatherCards[index].maxTemp,
                minTemp: WeatherData.dailyWeatherCards[index].minTemp
              );
            },
          )
          */
          
          //Daily Weather for Week
          child: DailyWeatherCard(
            weekday: "Monday",
            weatherCondition: 302,
            maxTemp: 33,
            minTemp: 22,
          ),
        ),
      ]
    );
  }
}