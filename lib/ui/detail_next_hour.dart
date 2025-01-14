import 'package:flutter/material.dart';
import '../models/weather_next_hour.dart';
import 'package:intl/intl.dart';

class DetailNextHour extends StatelessWidget {
  final WeatherNextHour forecast;
  final String location;

  const DetailNextHour({Key? key, required this.location, required this.forecast})
      : super(key: key);

  String _formatTime(String time) {
    try {
      final DateTime dateTime = DateTime.parse(time);
      final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      return formatter.format(dateTime);
    } catch (e) {
      return "Invalid time";
    }
  }

  String _getBackgroundImage() {
    if (forecast.description == null) return 'assets/default_background.jpg';

    switch (forecast.description!.toLowerCase()) {
      case 'clear sky':
        return 'assets/clear.jpg';
      case 'few clouds':
        return 'assets/cloudy.jpg';
      case 'scattered clouds':
        return 'assets/cloudy.jpg';
      case 'overcast clouds':
        return 'assets/cloudy.jpg';
      case 'broken clouds':
        return 'assets/cloudy.jpg';
      case 'shower rain':
        return 'assets/rainy.jpg';
      case 'light rain':
        return 'assets/rainy.jpg';
      case 'thunderstorm':
        return 'assets/thunderstorm.jpg';
      case 'snow':
        return 'assets/snow.jpg';
      case 'mist':
        return 'assets/mist.jpg';
      default:
        return 'assets/default_background.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details - ${forecast.timeForecast}'),
        backgroundColor: Colors.blueAccent,
        elevation: 16,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_getBackgroundImage()),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.darken),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Text(
                      'Weather Forecast for ${_formatTime(forecast.timeForecast ?? "Unknown Time")}',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(blurRadius: 10.0, color: Colors.black45, offset: Offset(2.0, 2.0)),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Colors.white70),
                  _buildWeatherDetail('Temperature', '${forecast.temp?.toStringAsFixed(1) ?? "N/A"}°C'),
                  const SizedBox(height: 20),
                  _buildWeatherDetail('Humidity', '${forecast.humidity?.toStringAsFixed(0) ?? "N/A"}%'),
                  const SizedBox(height: 20),
                  _buildWeatherDetail('Weather', forecast.description ?? "Unknown weather"),
                  const SizedBox(height: 30),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          mapWeatherIcon(forecast.icon),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.cloud_off, size: 100, color: Colors.grey);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24.0),
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: Offset(10, 10),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            blurRadius: 20,
            offset: Offset(-10, -10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey.shade700,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  String mapWeatherIcon(String? apiIcon) {
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
}
