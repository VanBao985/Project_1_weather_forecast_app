import 'package:flutter/material.dart';
import '../models/weather_next_hour.dart';
import '../api/weather_api.dart';
import 'package:intl/intl.dart';

class NextHourScreen extends StatefulWidget {
  final String cityName;

  const NextHourScreen({Key? key, required this.cityName}) : super(key: key);

  @override
  _NextHourScreenState createState() => _NextHourScreenState();
}

class _NextHourScreenState extends State<NextHourScreen> {
  late Future<List<WeatherNextHour>> weatherNextHour;

  @override
  void initState() {
    super.initState();
    weatherNextHour = _fetchWeatherData();
  }

  Future<List<WeatherNextHour>> _fetchWeatherData() async {
    try {
      final data = await WeatherApi.fetchWeatherNextHour(widget.cityName);
      return data;
    } catch (e) {
      debugPrint("Error fetching weather data: $e");
      return [];
    }
  }

  String _mapWeatherIcon(String? apiIcon) {
    final Map<String, String> iconMap = {
      "01d": "clear.png",
      "01n": "clear_night.png",
      "02d": "lightcloud.png",
      "02n": "lightcloud.png",
      "03d": "heavycloud.png",
      "03n": "heavycloud.png",
      "04d": "overcast.png",
      "04n": "overcast.png",
      "09d": "showers.png",
      "09n": "showers.png",
      "10d": "lightrain.png",
      "10n": "lightrain.png",
      "11d": "heavyrain.png",
      "11n": "heavyrain.png",
      "13d": "snow.png",
      "13n": "snow.png",
      "50d": "mist.png",
      "50n": "mist.png",
    };

    if (apiIcon == null || !iconMap.containsKey(apiIcon)) {
      return "assets/unchecked.png";
    }
    return "assets/${iconMap[apiIcon]}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hourly Forecast - ${widget.cityName}'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<WeatherNextHour>>(
          future: weatherNextHour,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final weatherDataList = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: weatherDataList.length,
                itemBuilder: (context, index) {
                  return HourlyWeatherCard(
                    forecast: weatherDataList[index],
                    mapWeatherIcon: _mapWeatherIcon,
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  'No data available.',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class HourlyWeatherCard extends StatelessWidget {
  final WeatherNextHour forecast;
  final String Function(String?) mapWeatherIcon;

  const HourlyWeatherCard({Key? key, required this.forecast, required this.mapWeatherIcon}) : super(key: key);
  String _formatTime(String time) {
    try {
      final DateTime dateTime = DateTime.parse(time);
      final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      return formatter.format(dateTime);
    } catch (e) {
      return "Invalid time";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                mapWeatherIcon(forecast.icon),
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.cloud_off, size: 50, color: Colors.grey); // Hiển thị khi lỗi tải icon
                },
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatTime(forecast.timeForecast ?? "Unknown Time"),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${forecast.temp.toStringAsFixed(1)}°C',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    forecast.description ?? "Unknown weather",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
        ],
      ),
    );
  }
}
