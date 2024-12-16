import 'package:flutter/material.dart';
import '../models/weather_next_hour.dart';
import '../api/weather_api.dart';

class NextHourScreen extends StatefulWidget {
  final String cityName;

  const NextHourScreen({Key? key, required this.cityName}) : super(key: key);

  @override
  _NextHourScreenState createState() => _NextHourScreenState();
}

class _NextHourScreenState extends State<NextHourScreen> {
  late Future<List<WeatherNextHour>> weatherNextHour;
  List<String> missingIcons = [];

  @override
  void initState() {
    super.initState();
    weatherNextHour = WeatherApi.fetchWeatherNextHour(widget.cityName);
  }

  // Map API icon to local asset icon
  String _mapWeatherIcon(String? apiIcon) {
    final Map<String, String> iconMap = {
      "01d": "clear.png",
      "01n": "clear.png",
      "02d": "lightcloud.png",
      "02n": "lightcloud.png",
      "03d": "cloudy.png",
      "03n": "cloudy.png",
      "04d": "overcast.png",
      "04n": "overcast.png",
      "09d": "showers.png",
      "09n": "showers.png",
      "10d": "heavyrain.png",
      "10n": "heavyrain.png",
      "11d": "thunderstorm.png",
      "11n": "thunderstorm.png",
      "13d": "snow.png",
      "13n": "snow.png",
      "50d": "mist.png",
      "50n": "mist.png",
    };

    if (apiIcon == null || !iconMap.containsKey(apiIcon)) {
      if (!missingIcons.contains(apiIcon ?? "")) {
        missingIcons.add(apiIcon ?? "Unknown");
      }
      return "assets/unchecked.png"; // Default icon for missing icon
    }
    return "assets/${iconMap[apiIcon] ?? "unchecked.png"}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Hour Forecast for ${widget.cityName}'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<WeatherNextHour>>(
        future: weatherNextHour,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<WeatherNextHour> weatherDataList = snapshot.data!;
            return Column(
              children: [
                NextHour(hourlyForecast: weatherDataList, mapWeatherIcon: _mapWeatherIcon),
                if (missingIcons.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Missing Icons: ${missingIcons.join(", ")}\nPlease add corresponding images in the assets.',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
              ],
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}

class NextHour extends StatelessWidget {
  final List<WeatherNextHour> hourlyForecast;
  final String Function(String?) mapWeatherIcon;

  const NextHour({Key? key, required this.hourlyForecast, required this.mapWeatherIcon}) : super(key: key);

  double _convertToDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return 0.0; // Default value if data is invalid
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: hourlyForecast.length,
        itemBuilder: (context, index) {
          return HourlyWeatherCard(forecast: hourlyForecast[index], mapWeatherIcon: mapWeatherIcon);
        },
      ),
    );
  }
}

class HourlyWeatherCard extends StatelessWidget {
  final WeatherNextHour forecast;
  final String Function(String?) mapWeatherIcon;

  const HourlyWeatherCard({Key? key, required this.forecast, required this.mapWeatherIcon}) : super(key: key);

  double _convertToDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            mapWeatherIcon(forecast.icon),
            width: 50,
            height: 50,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.cloud_off, size: 50, color: Colors.grey);
            },
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  forecast.timeForecast ?? "Unknown time",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_convertToDouble(forecast.temp).toStringAsFixed(1)}°C',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey[600],
          ),
        ],
      ),
    );
  }
}
