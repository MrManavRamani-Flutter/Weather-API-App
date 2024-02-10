import 'package:flutter/material.dart';
import 'package:sky_scrapper_api/models/weather_model.dart';
import 'package:sky_scrapper_api/views/widgets/weather_detail_row.dart';

class WeatherInfo extends StatefulWidget {
  final Weather weather;

  const WeatherInfo({super.key, required this.weather});

  @override
  _WeatherInfoState createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FadeTransition(
        opacity: _animation,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.weather.locationName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Region: ${widget.weather.region}',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                'Country: ${widget.weather.country}',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const Divider(),
              WeatherDetailRow(
                label: 'Temperature:',
                value:
                    '${widget.weather.temperatureCelsius}°C / ${widget.weather.temperatureFahrenheit}°F',
              ),
              WeatherDetailRow(
                label: 'Wind Speed:',
                value: '${widget.weather.windSpeedKph} km/h',
              ),
              WeatherDetailRow(
                label: 'Cloud:',
                value: '${widget.weather.cloud}',
                icon: Icons.cloud,
              ),
              WeatherDetailRow(
                label: 'Feels like:',
                value:
                    '${widget.weather.feelsLikeCelsius}°C / ${widget.weather.feelsLikeFahrenheit}°F',
                icon: Icons.thermostat,
              ),
              WeatherDetailRow(
                label: 'Visibility:',
                value: '${widget.weather.visibilityKm} km',
                icon: Icons.visibility,
              ),
              WeatherDetailRow(
                label: 'Humidity:',
                value: '${widget.weather.humidity}%',
                icon: Icons.water,
              ),
              WeatherDetailRow(
                label: 'Wind Direction:',
                value: '${widget.weather.windDirection}',
                icon: Icons.arrow_forward,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 1......................................................................................
// import 'package:flutter/material.dart';
// import 'package:sky_scrapper_api/models/weather_model.dart';
//
// class WeatherInfo extends StatefulWidget {
//   final Weather weather;
//
//   const WeatherInfo({super.key, required this.weather});
//
//   @override
//   _WeatherInfoState createState() => _WeatherInfoState();
// }
//
// class _WeatherInfoState extends State<WeatherInfo>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _controller.forward();
//     return FadeTransition(
//       opacity: _animation,
//       child: Container(
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16.0),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.3),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.weather.locationName,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Region: ${widget.weather.region}',
//               style: const TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               'Country: ${widget.weather.country}',
//               style: const TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//             const Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Temperature:',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 Text(
//                   '${widget.weather.temperatureCelsius}°C / ${widget.weather.temperatureFahrenheit}°F',
//                   style: const TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Wind Speed:',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 Text(
//                   '${widget.weather.windSpeedKph} km/h',
//                   style: const TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Icon(Icons.cloud, size: 30, color: Colors.grey),
//                 Text(
//                   '${widget.weather.cloud}',
//                   style: const TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Icon(Icons.thermostat, size: 30, color: Colors.grey),
//                 Text(
//                   'Feels like: ${widget.weather.feelsLikeCelsius}°C / ${widget.weather.feelsLikeFahrenheit}°F',
//                   style: const TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Icon(Icons.visibility, size: 30, color: Colors.grey),
//                 Text(
//                   'Visibility: ${widget.weather.visibilityKm} km',
//                   style: const TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Icon(Icons.water, size: 30, color: Colors.grey),
//                 Text(
//                   'Humidity: ${widget.weather.humidity}%',
//                   style: const TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Icon(Icons.arrow_forward, size: 30, color: Colors.grey),
//                 Text(
//                   'Wind Direction: ${widget.weather.windDirection}',
//                   style: const TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
