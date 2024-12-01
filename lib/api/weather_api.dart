import 'dart:convert';

import 'package:weather_app/models/weather_next_hour.dart';

import '../models/city.dart';
import '../models/weather.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'city_api.dart';

// fetchWeatherData(int id): thoi tiet hien tai, lay theo Id, ung voi models/weather.dart
// fetchWeatherNextHour(int id): thoi tiet cac gio toi, ung voi models/weather_next_hour
// Chu y cach goi ham: Can toi 1 method void async de thuc hien (vi van de dong bo)
// Chi tiet tham khao phan Test duoc comment ben duoi

class WeatherApi {
  static String searchWeatherUrl = "https://api.openweathermap.org/data/2.5/weather?id=";
  static String keyId = "&appid=1d1bfe48aa13dad3784949d470fd8781";
  static String searchNextHour = "https://api.openweathermap.org/data/2.5/forecast?id=";
  static int getIdFromCity(String name){
    int _id = -1;
    List<City> citiesList = City.citiesList;
    for (City city in citiesList){
      if (city.name == name){
        _id = city.id;
        break;
      }
    }
    return _id;
  }

  static Future<Weather> fetchWeatherData(String name) async {
    int id = WeatherApi.getIdFromCity(name);
    var weatherResult = await http.get(
        Uri.parse(searchWeatherUrl + id.toString() + keyId));
    if (weatherResult.statusCode != 200) {
      throw Exception("Failed to fetch weather data. Status code: ${weatherResult.statusCode}");
    }
    var result = json.decode(weatherResult.body);
    int sunrise = result['sys']['sunrise'];
    int sunset = result['sys']['sunset'];
    DateTime sunriseTime = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000, isUtc: true);
    DateTime sunsetTime = DateTime.fromMillisecondsSinceEpoch(sunset * 1000, isUtc: true);
    String formattedSunrise = DateFormat("HH:mm").format(sunriseTime.toLocal());
    String formattedSunset = DateFormat("HH:mm").format(sunsetTime.toLocal());
    Weather weather = Weather(
        id : result["id"],
        main: result["weather"][0]["main"],
        description: result["weather"][0]["description"],
        icon: result["weather"][0]['icon'],
        temp: result["main"]["temp"] - 273.15,
        feels_like: result["main"]["feels_like"] - 273.15,
        wind: result['wind']['speed'],
        humidity: result['main']['humidity'],
        sunrise: formattedSunrise,
        sunset: formattedSunset
    );
    return weather;
  }
  static Future<List<WeatherNextHour>> fetchWeatherNextHour(String name) async{
    List<WeatherNextHour> weatherNextHourList = [];
    int id = WeatherApi.getIdFromCity(name);
    var weatherResult = await http.get(
        Uri.parse(searchNextHour + id.toString() + keyId));
    if (weatherResult.statusCode != 200) {
      throw Exception("Failed to fetch weather data. Status code: ${weatherResult.statusCode}");
    }
    var result = json.decode(weatherResult.body);
    for (var item in result['list']) {
      int timestamp = item['dt'];
      DateTime utcTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
      DateTime localTime = utcTime.toLocal();
      WeatherNextHour wtNH = WeatherNextHour(
        id: result['city']['id'],
        main: item['weather'][0]['main'],
        description: item['weather'][0]['description'],
        icon: item['weather'][0]['icon'],
        temp: item['main']['temp'] - 273.15,
        feels_like: item['main']['feels_like'] - 273.15,
        wind: item['wind']['speed'],
        humidity: item['main']['humidity'],
        timeForecast: localTime.toString()
      );
      weatherNextHourList.add(wtNH);
    }
    return weatherNextHourList;
  }
}

// Test function fetchWeatherData:
// class TestAPI{
//   static Weather weather = Weather();
//   static void fetchData() async{
//     weather = await WeatherApi.fetchWeatherData("Ha Noi");
//     print(weather.temp);
//   }
// }
// void main() async {
//   TestAPI.fetchData();
// }

// Test function fetchWeatherNextHour:
// class TestAPI{
//   List<WeatherNextHour> weatherNextHour = [];
//   void fetchData() async{
//     weatherNextHour = await WeatherApi.fetchWeatherNextHour("Ha Noi");
//     for (WeatherNextHour wtNH in weatherNextHour){
//       print(wtNH.timeForecast);
//     }
//   }
// }
// void main() async {
//   TestAPI testAPI = TestAPI();
//   testAPI.fetchData();
// }