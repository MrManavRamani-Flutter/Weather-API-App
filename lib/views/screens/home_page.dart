import 'package:flutter/material.dart';
import 'package:sky_scrapper_api/provider/weather_provider.dart';
import 'package:sky_scrapper_api/views/screens/weather_info.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final TextEditingController searchController = TextEditingController();

  final WeatherProvider weatherProvider = WeatherProvider();
  // Assuming you have defined WeatherProvider

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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Weather App',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://t3.ftcdn.net/jpg/05/80/90/24/240_F_580902442_xmjBIVys6czucJ4T8JgbSxh6h7EAAn1P.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Enter City, State or Country',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.cloud_done),
                    onPressed: () {
                      weatherProvider.fetchWeatherData(searchController.text);
                    },
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                            )
                          : Expanded(
                              child: WeatherInfo(
                                weather: weatherProvider.weather!,
                              ),
                            ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
