import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:weatherapp/utils/daynight.dart';
import 'package:weatherapp/utils/string_formatter.dart';
import 'package:weatherapp/utils/location.dart';
import 'package:weatherapp/utils/network.dart';
import 'package:weatherapp/models/geocoding.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/models/dailyweather.dart';
import 'package:weatherapp/widgets/weather_display.dart';
import 'package:weatherapp/widgets/daily_weather_display.dart';

class MainDisplay extends StatefulWidget {
  static const String id = '/main_screen';
  final WeatherData weatherData;
  final GeoData geoData;
  
  MainDisplay({required this.weatherData, required this.geoData});

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

  //Variables for refresh function
  late LocationHelper newLocation;
  late WeatherData newWeather;
  late GeoData newGeo;

  void updateDisplayInfo(WeatherData weatherData, GeoData geoData) {
    weatherData.dailyWeatherCards.clear();

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

  Future<void> refreshInfo() async{
    //Refresh Location, Update Geodata and Refresh Weather
    newLocation = LocationHelper();
    await newLocation.getCurrentLocation();

    newGeo = GeoData(locationData: newLocation);
    await newGeo.getGeolocationData();

    newWeather = WeatherData(locationData: newLocation);
    await newWeather.getCurrentTemperature();
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
                  /*
                  child: DailyWeatherCard(
                    weekday: "Monday",
                    maxTemp: 33,
                    minTemp: 22,
                  ),
                  */
                  child: FutureBuilder(
                    builder: (
                      BuildContext context, 
                      AsyncSnapshot<dynamic> snapshot
                    ){  
                      return Container(
                        child: ListView.builder(
                          shrinkWrap: true, 
                          physics: ClampingScrollPhysics(),
                          itemCount: widget.weatherData.dailyWeatherCards.length,
                          itemBuilder: (context, index){
                            print("$context");
                            return DailyWeatherCard(
                              weekday: widget.weatherData.dailyWeatherCards[index].weekday,
                              //conditionWeather: newWeather.dailyWeatherCards[index].conditionWeather,
                              maxTemp: widget.weatherData.dailyWeatherCards[index].maxTemp,
                              minTemp: widget.weatherData.dailyWeatherCards[index].minTemp,
                            );
                          },
                        ),
                      );
                    },
                  ),
              ),
            ),
          )
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        //Refresh Location, Update Geodata and Refresh Weather
        await refreshInfo();

        print("Updated UI");

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