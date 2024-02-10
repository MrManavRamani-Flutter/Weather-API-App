import 'package:flutter/material.dart';
import 'package:sky_scrapper_api/models/weather_model.dart';

class WeatherInfo extends StatelessWidget {
  final Weather weather;

  WeatherInfo({Key? key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Location: ${weather.locationName}, ${weather.region}, ${weather.country}',
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          'Temperature: ${weather.temperatureCelsius}°C',
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          'Wind Speed: ${weather.windSpeedKph} km/h',
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          'Cloud: ${weather.cloud}',
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          'Feels Like: ${weather.feelsLikeCelsius}°C',
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          'Visibility: ${weather.visibilityKm} km',
          style: const TextStyle(fontSize: 20),
        ),
        // Add more weather information widgets here
      ],
    );
  }
}
