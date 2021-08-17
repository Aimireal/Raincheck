//  @dart=2.9
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:weatherapp/utils/daynight.dart';
import 'package:weatherapp/utils/string_formatter.dart';
import 'package:weatherapp/utils/location.dart';
import 'package:weatherapp/models/geocoding.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/models/dailyweather.dart';
import 'package:weatherapp/widgets/weather_display.dart';
import 'package:weatherapp/widgets/daily_weather_display.dart';

class MainDisplay extends StatefulWidget {
  static const String id = '/main_screen';
  final WeatherData weatherData;
  final GeoData geoData;
  
  MainDisplay({this.weatherData, this.geoData});

  @override
  _MainDisplayState createState() => _MainDisplayState();
}

class _MainDisplayState extends State<MainDisplay> {
  //Taking values from the WeatherData object for display
  int temperature;
  int tempMin;
  int tempMax;
  int humidity;
  int windSpeed;

  //Added temp values for strings
  String weatherDesc = "";
  String locationName = "";
  String countryName = "";

  Icon weatherDisplayIcon;
  AssetImage backgroundImage;

  //Variables for refresh function
  LocationHelper newLocation;
  WeatherData newWeather;
  GeoData newGeo;

  /*
  ToDo: This is the original values. Changed to try use dart 2.9 to disable null safety
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
  */

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
    updateDisplayInfo(widget.weatherData, widget.geoData);
    super.initState();
    print(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return Scaffold(
      body: Container(
        child: PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          children: <Widget>[
            new Container(
              color: DayNight().cardBackground(),
              child: Center(
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
            ),
            new Container(
              color: DayNight().cardBackground(),
              child: Center(
                child: new Container(
                  child: DailyWeatherCard(
                    weekday: "Monday",
                    weatherCondition: 302,
                    maxTemp: 33,
                    minTemp: 22,
                    /*
                    ToDo: Figure why index error is happening. Seems to not recognise JSONReading on "Daily"
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
                    )*/
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //Refresh Location
          newLocation = LocationHelper();
          await newLocation.getCurrentLocation();

          var lat = newLocation.latitude;
          var lon = newLocation.longitude;
          print("Lat = $lat, Lon = $lon");

          //Update GeoData
          newGeo = GeoData(locationData: newLocation);
          await newGeo.getGeolocationData();

          var country = newGeo.currentCountry;
          var city = newGeo.currentCity;
          print("Country = $country, City = $city");

          //Refresh Weather
          newWeather = WeatherData(locationData: newLocation);
          await newWeather.getCurrentTemperature();

          var newTemp = newWeather.currentTemp;
          print("New Temp: $newTemp");

          //Update UI with new values
          updateDisplayInfo(newWeather, newGeo);
          print("Updated Widget");
        },
        child: const Icon(Icons.refresh),
        backgroundColor: Colors.grey,
        ),
      );
  }

}