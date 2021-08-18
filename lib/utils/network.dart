import 'package:http/http.dart';
import 'package:weatherapp/credentials.dart';
import 'package:weatherapp/constants.dart';

class NetworkService{
  String key = apiKey;

  Future<Response> getCurrentTemperature(locationData) async{
    Response response = await get(
      //One call API. Returns more data than the standard data
      Uri.parse(
        '$openWeatherURL?lat=${locationData.latitude}&lon=${locationData.longitude}&exclude=&appid=$apiKey&units=$appUnits&lang=$appLang'
        )
    );
    return response;
  }
}