import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wheatherio/weather/models/weather_model.dart';

class WeatherService {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5';
  static final http.Client httpClient = http.Client();

  static Future<WeatherModel> getWeather(String location) async {
    final url = '$baseUrl/forecast?q=$location&lang=fr&appid=b70b236b4ba6d6796be6970a199d490f';
    final response = await httpClient.get(Uri.parse(url));

    if(response.statusCode != 200) {
      throw Exception('Erreur dans la récupération de la météo.');
    }

    return WeatherModel.fromJson(jsonDecode(response.body));
  }
}
