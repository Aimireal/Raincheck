import 'package:flutter/material.dart';

class Weather_display extends StatelessWidget {
  const Weather_display({
    Key? key,
    required this.backgroundImage,
    required this.weatherDisplayIcon,
    required this.temperature,
    required this.locationName,
    required this.countryName,
    required this.weatherDesc,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.windSpeed,
  }) : super(key: key);

  final AssetImage backgroundImage;
  final Icon weatherDisplayIcon;
  final int temperature;
  final String locationName;
  final String countryName;
  final String weatherDesc;
  final int tempMin;
  final int tempMax;
  final int humidity;
  final int windSpeed;

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