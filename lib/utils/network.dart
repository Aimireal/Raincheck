import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:weatherapp/credentials.dart';

String key = apiKey;

class NetworkService{
  final String url;
  NetworkService(String s, {required this.url});

  Future fetchAPI(String url) async{
    final response = await http.get(url as Uri);

    if(response.statusCode == 200){
      return convert.jsonDecode(response.body);
    } else{
      throw Exception('Failed to fetch API');
    }
  }
}