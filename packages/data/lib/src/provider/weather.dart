import 'dart:convert';
import 'dart:developer';

import 'package:data/data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class WeatherProvider {
  static const baseUrl = 'https://www.metaweather.com';

  final Client httpClient;

  WeatherProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<int> getLocationId(String city) async {
    final locationUrl = '$baseUrl/api/location/search/?query=$city';
    final locationResponse = await this.httpClient.get(Uri.tryParse(locationUrl));

    log('$locationUrl ${locationResponse.statusCode} ${locationResponse.body}');

    if (locationResponse.statusCode != 200) {
      throw Exception('error getting locationId for city');
    }

    final locationJson = jsonDecode(locationResponse.body) as List;
    return (locationJson.first)['woeid'];
  }

  Future<Weather> fetchWeather(int locationId) async {
    final weatherUrl = '$baseUrl/api/location/$locationId';
    final weatherResponse = await this.httpClient.get(Uri.tryParse(weatherUrl));

    log('$weatherUrl ${weatherResponse.statusCode} ${weatherResponse.body}');

    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    return Weather.fromJson(weatherJson);
  }
}