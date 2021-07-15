import 'package:flutter/material.dart';
import 'package:weatherapp/screens/loading_screen.dart';

//Runnable instance
void main(){
  runApp(MyApp());
}

//Application root
class MyApp extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: LoadingScreen(),
      ),
    );
  }
}