import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/utils/daynight.dart';
import 'package:weatherapp/constants.dart';

class DailyWeatherCard extends StatelessWidget{
  final String weekday;
  //final int weatherCondition;
  final dynamic maxTemp;
  final dynamic minTemp;

  final backColor = DayNight().cardBackground();
  final foreColor = DayNight().cardForeground();

  DailyWeatherCard(
    {
      required this.weekday,
      //required this.weatherCondition,
      required this.maxTemp,
      required this.minTemp,
    }
  );

  @override 
  Widget build(BuildContext context){
    return Padding(
      padding:EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color:foreColor,
          borderRadius: BorderRadius.circular(20),
        ),  
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  weekday,
                  style: kWeekdayStyle,
                ),
              ),
              //Icon changer doesn't use images directly. May need to split functionality
              /*Expanded(
                flex: 1,
                child: Image(
                  //image:WeatherData().getWeatherDisplayData(),
                  width: 20,
                  height: 20,
                ),
              ),
              */
              Row(
                children: <Widget>[
                  Text(
                    '${maxTemp.toString()}°C',
                    style: kMaxTempStyle,
                  ),
                  SizedBox(width:15),
                  Text(
                    '${minTemp.toString()}°C',
                    style: kMinTempStyle,
                  )
                ],
              ),
            ],
          )
        ),
      )
    );
  }
}