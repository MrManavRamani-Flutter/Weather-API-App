import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_scrapper_api/provider/weather_provider.dart';
import 'package:sky_scrapper_api/views/screens/weather_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Enter City, State or Country',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  weatherProvider.fetchWeatherData(searchController.text);
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          weatherProvider.weather == null
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: _animation,
                        child: const Text(
                          "Weather data not available",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      RotationTransition(
                        turns: _animation,
                        child: const Icon(
                          Icons.cloud,
                          size: 50,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  // child: const CircularProgressIndicator(),
                )
              : Expanded(child: WeatherInfo(weather: weatherProvider.weather!)),
        ],
      ),
    );
  }
}
