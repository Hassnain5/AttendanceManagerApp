import 'dart:convert';
import 'package:first_app/const/ApiKey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:first_app/models/WeatherModel.dart';

class WeatherProvider extends ChangeNotifier {
  final api_key= ApiKey().apiKey;
  String _city ="Sahiwal";

  String get city=>_city;
  void setCity(String city){
    _city=city;
    notifyListeners();
  }

  Future<WeatherModel?> getWeather() async{
    final response =
    await http.get(Uri.parse("http://api.weatherapi.com/v1/current.json?key=$api_key&q=$city&aqi=no"));
    print(response.statusCode);
    if(response.statusCode== 200){

      final responseData = jsonDecode(response.body);
      try {
        final weather = WeatherModel.fromJson(responseData);
        print("Parsed Weather: ${weather.location?.name}");
        return weather;
      } catch (e) {
        print("Error parsing WeatherModel: $e");
        return null;
      }
    }else
      return null;

    notifyListeners();
  }
}
