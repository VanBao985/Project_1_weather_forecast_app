import 'package:weather_app/models/weather.dart';

class WeatherNextHour extends Weather{
  late String timeForecast;

  WeatherNextHour({
    super.id,
    super.main,
    super.description,
    super.icon,
    super.temp,
    super.feels_like,
    super.wind,
    super.humidity,
    super.sunrise,
    super.sunset,
    this.timeForecast = "",
  });
}