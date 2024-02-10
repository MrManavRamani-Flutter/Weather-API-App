import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sky_scrapper_api/models/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;

  Weather? get weather => _weather;

  Future<void> fetchWeatherData(String text) async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.weatherapi.com/v1/current.json?key=df08ef1012764017bdc90419240802&q=${text}&aqi=no'));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        _weather = Weather.fromJson(decodedData);
        notifyListeners();
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      throw Exception('Failed to load weather data: $error');
    }
  }
}
