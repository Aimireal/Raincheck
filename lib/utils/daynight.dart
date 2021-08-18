import 'package:flutter/material.dart';
import 'package:weatherapp/constants.dart';

class DayNight{
  /*
  ToDo: Implement change below
  So a better way to do this would be to run on refresh the "isDay" code
  That way we can get the boolean on refresh, and send to these methods 
  instead of rerunning that line of code, will change later since feel it 
  is not required and I might need to overhaul refreshing/loading.
  */

  //Check if it is day or night
  bool isDay(){
    var currentTime = new DateTime.now();
    bool daytime;

    if(currentTime.hour >= 19){
      daytime = false;
    } else{
      daytime = true;
    }
    return daytime;
  }

  //Dyanmic background changer
  AssetImage backgroundChanger(){
    var dayNight;
    bool isDaytime = isDay();

    if(!isDaytime){
      dayNight = AssetImage('assets/backgroundnight.png');
    } else{
      dayNight = AssetImage('assets/backgroundday.png');
    }
    return dayNight;
  }

  //Dynamic icon changer
  ImageIcon iconChanger(){
    var clearIcon;
    bool isDaytime = isDay();

    if(!isDaytime){
      clearIcon = kMoonIcon;
    } else{
      clearIcon = kSunIcon;
    }
    return clearIcon;
    
  }

  Color cardBackground(){
    var color;
    bool isDayTime = isDay();

    if(!isDayTime){
      color = kBackDark;
    } else{
      color = kBackLight;
    }
    return color;
  }

  Color cardForeground(){
    var color;
    bool isDayTime = isDay();

    if(!isDayTime){
      color = kCardDark;
    } else{
      color = kCardLight;
    }
    return color;
  }
}