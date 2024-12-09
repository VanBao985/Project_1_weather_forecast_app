import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_next_hour.dart';
import 'package:weather_app/api/weather_api.dart';

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
    weatherNextHour = WeatherApi.fetchWeatherNextHour(widget.cityName); // Lấy dữ liệu dự báo theo giờ
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
            return ListView.builder(
              itemCount: weatherDataList.length,
              itemBuilder: (context, index) {
                WeatherNextHour weatherNextHour = weatherDataList[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network('https://openweathermap.org/img/wn/${weatherNextHour.icon}.png'),
                    title: Text('${weatherNextHour.temp.toStringAsFixed(1)}°C'),
                    subtitle: Text('${weatherNextHour.description}\nTime: ${weatherNextHour.timeForecast}'),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
