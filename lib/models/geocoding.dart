import 'dart:convert';
import 'package:http/http.dart';

import 'package:weatherapp/constants.dart';
import 'package:weatherapp/credentials.dart';
import 'package:weatherapp/utils/location.dart';

//Request geocoding from the API on lat/long
class GeoData{
  GeoData({required this.locationData});
  LocationHelper locationData;

  String currentCity = "";
  String currentCountry = "";

  //ToDo: Retrieve the locationData once in a parent class, then give value to geocoding.dart and weather.dart. Maybe make generic method for API
  Future<void> getGeolocationData() async{
    Response response = await get(
      Uri.parse('$reverseGeocoding?lat=${locationData.latitude}&lon=${locationData.longitude}&limit=1&appid=$apiKey')
    );

    //Return geocode values
    if(response.statusCode == 200){
      String data = response.body;
      var currentGeoData = jsonDecode(data);
      try{
        currentCity = currentGeoData[0]['name'];
        currentCountry = currentGeoData[0]['country'];
      }catch(e){
        print("Exception: $e");
      }
    }else{
      print('Error: Unable to fetch weather data');
    }
  }
}