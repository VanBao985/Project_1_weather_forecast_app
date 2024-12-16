import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/weather_next_hour.dart';
import 'package:weather_app/ui/select_city.dart';
import 'package:weather_app/widgets/weather_item.dart';

import 'next_hour.dart';  // Import weatherItem widget

class Home extends StatefulWidget {
  final String location;
  const Home({Key? key, required this.location}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String location;
  Weather? currentWeather;
  bool isLoading = true;

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void initState() {
    super.initState();
    location = widget.location; // Set location from constructor
    fetchCurrentWeather();
  }

  Future<void> fetchCurrentWeather() async {
    setState(() {
      isLoading = true;
    });
    try {
      Weather weather = await WeatherApi.fetchWeatherData(location);
      setState(() {
        currentWeather = weather;
      });
    } catch (e) {
      print("Error fetching weather data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/profile.png',
                  width: 50,
                  height: 50,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectCity(),
                    ),
                  ).then((selectedLocation) {
                    if (selectedLocation != null) {
                      setState(() {
                        location = selectedLocation;
                      });
                      fetchCurrentWeather();
                    }
                  });
                },
                child: Text(
                  location,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : currentWeather == null
          ? const Center(child: Text("Không thể tải dữ liệu thời tiết."))
          : Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              Text(
                DateFormat('dd MMMM yyyy').format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),
              Container(
                width: size.width,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -40,
                      left: 20,
                      child: Image.network(
                        'https://openweathermap.org/img/wn/${currentWeather!.icon}@2x.png',
                        width: 150,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.cloud, size: 150, color: Colors.white);
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 20,
                      child: Text(
                        currentWeather!.description,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              currentWeather!.temp.round().toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = linearGradient,
                              ),
                            ),
                          ),
                          const Text(
                            '°C',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Using weatherItem widget
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    weatherItem(
                      text: 'Tốc độ gió',
                      value: currentWeather!.wind.round(),
                      unit: 'km/h',
                      imageUrl: 'assets/windspeed.png',
                    ),
                    weatherItem(
                      text: 'Độ ẩm',
                      value: currentWeather!.humidity.round(),
                      unit: '%',
                      imageUrl: 'assets/humidity.png',
                    ),
                    weatherItem(
                      text: 'Cảm giác như',
                      value: currentWeather!.feels_like.round(),
                      unit: '°C',
                      imageUrl: 'assets/max-temp.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NextHourScreen(cityName: location),
                      ),
                    );
                  },
                  child: Text(
                    ("Forecast weather for next hour for $location"),
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}