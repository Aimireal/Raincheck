import 'package:flutter/material.dart';
import 'weather_tile.dart';

class MainWidget extends StatelessWidget{
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  MainWidget({
    @required this.location,
    @required this.temp,
    @required this.tempMin,
    @required this.tempMax,
    @required this.weather,
    @required this.humidity,
    @required this.windSpeed
  });

  //Build the widget for displaying weather
  @override
  Widget build (BuildContext context){
    return Column(children: [
      Container(
        height: MediaQuery.of(context).size.height / 2, 
        width: MediaQuery.of(context).size.width,
        color: Color(0xfff0c0913),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${location.toString()}", 
              style: TextStyle(
                fontSize: 30.0, 
                fontWeight: FontWeight.w900,
                color: Color(0xff9e9e9e)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    "${temp.toInt().toString()}°",
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                ),
                Text(
                  "Highs of ${tempMax.toString()}°, Lows of ${tempMin.toString()}°",
                  style: TextStyle(
                    color: Color(0xff9e9e9e),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600
                  ),
                )
            ],
          ),
        ),
        Expanded(
          child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  WeatherTile(icon: Icons.thermostat_outlined, title: "Temperature", subtitle: "${temp.toInt().toString()}°"),
                  WeatherTile(icon: Icons.filter_drama_outlined, title: "Weather", subtitle: "${weather.toString()}"),
                  WeatherTile(icon: Icons.wb_sunny, title: "Humidity", subtitle: "${humidity.toString()}%"),
                  WeatherTile(icon: Icons.waves_outlined, title: "Wind Speed", subtitle: "${windSpeed.toInt().toString()} MPH")
                ],
            )
          )
        )
      ],
    );  
  }
}