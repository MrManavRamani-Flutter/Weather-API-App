import 'package:flutter/material.dart';
import 'package:sky_scrapper_api/Helper/weather_api.dart';
import 'package:sky_scrapper_api/models/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;

  Weather? get weather => _weather;

  Future<void> fetchWeatherData(String text) async {
    try {
      final decodedData = await WeatherApi.fetchWeatherData(text);
      _weather = Weather.fromJson(decodedData);
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to load weather data: $error');
    }
  }
}
