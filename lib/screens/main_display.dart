import 'package:flutter/material.dart';

import 'package:weatherapp/utils/weather.dart';
import 'package:weatherapp/utils/geocoding.dart';
import 'package:weatherapp/utils/string_formatter.dart';

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
  late String weatherDesc = "Bit chilly";
  late String locationName = "Bradford";
  late String countryName = "GB";

  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;

  void updateDisplayInfo(WeatherData weatherData, GeoData geoData) {
    setState(() {
      temperature = weatherData.currentTemp.round();
      tempMin = weatherData.currentTempMin.round();
      tempMax = weatherData.currentTempMax.round();
      humidity = weatherData.currentHumidity.toInt();
      windSpeed = weatherData.currentWindSpeed.round();

      //Apply capitalise function from string_formatter
      //weatherDesc = weatherData.currentDescription.capitalise();
      //locationName = geoData.currentLocation.capitalise();
      //countryName = geoData.currentCountry;

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

  //Surely there is a better layout system???? Widgetbuilder maybe limiting
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 85,
            ),
            Container(
              child: weatherDisplayIcon,
            ),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: Text(
                ' $temperature°',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80.0,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                '$locationName, $countryName', 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                '$weatherDesc',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 40.0,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Min: $tempMin° Max: $tempMax",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 30.0,
                ),
              ),
            ),
            SizedBox(
              height: 55,
            ),
            Center(
              child: Text(
                "Humidity: $humidity%",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Wind Speed: $windSpeed MPH",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}