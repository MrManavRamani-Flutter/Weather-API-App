import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_scrapper_api/provider/weather_provider.dart';
import 'package:sky_scrapper_api/views/screens/weather_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late TextEditingController searchController = TextEditingController();
  final WeatherProvider weatherProvider = WeatherProvider();
  late List<String> savedLocations = [];

  Future<void> saveLocation(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedLocations = prefs.getStringList('savedLocations') ?? [];
    savedLocations.add(location);
    await prefs.setStringList('savedLocations', savedLocations);
  }

  Future<List<String>> getSavedLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('savedLocations') ?? [];
  }

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
    loadSavedLocations();
    _animationController.repeat(reverse: true);
  }

  Future<void> loadSavedLocations() async {
    savedLocations = await getSavedLocations();
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.greenAccent.shade200.withOpacity(0.4),
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Text(
                  'Weather App',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.blue,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://t3.ftcdn.net/jpg/05/80/90/24/240_F_580902442_xmjBIVys6czucJ4T8JgbSxh6h7EAAn1P.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Enter City, State or Country',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        weatherProvider.fetchWeatherData(searchController.text);
                        saveLocation(searchController.text);
                        loadSavedLocations();
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
            // SliverPadding(
            //   padding: const EdgeInsets.all(16.0),
            //   sliver: SliverToBoxAdapter(
            //     child: TextField(
            //       controller: searchController,
            //       decoration: InputDecoration(
            //         hintText: 'Enter City, State or Country',
            //         suffixIcon: IconButton(
            //           icon: const Icon(Icons.search),
            //           onPressed: () {
            //             weatherProvider.fetchWeatherData(searchController.text);
            //           },
            //         ),
            //         filled: true,
            //         fillColor: Colors.grey[200],
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10),
            //           borderSide: BorderSide.none,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
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
                            ? Column(
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
                              )
                            : WeatherInfo(
                                weather: weatherProvider.weather!,
                              ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
