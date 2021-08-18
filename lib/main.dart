import 'package:flutter/material.dart';

import 'package:weatherapp/screens/loading_screen.dart';
import 'package:weatherapp/utils/daynight.dart';

//Runnable instance
void main(){
  runApp(MyApp());
}

//Application root
class MyApp extends StatelessWidget{
  @override 
  Widget build(BuildContext context){   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: DayNight().cardForeground(),
        scaffoldBackgroundColor: DayNight().cardBackground()
      ),
      initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        //MainDisplay.id: (context) => MainDisplay(),
      },
    );
  }
}