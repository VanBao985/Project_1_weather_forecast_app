import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/ui/select_city.dart';
import 'package:weather_app/widgets/weather_item.dart';
import 'next_hour.dart';

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
  String backgroundImage = 'assets/default.jpg';

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void initState() {
    super.initState();
    location = widget.location;
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
        if (currentWeather!.description.contains('clear')) {
          backgroundImage = 'assets/clear.jpg';
        } else if (currentWeather!.description.contains('rain')) {
          backgroundImage = 'assets/rainy.gif';
        } else if (currentWeather!.description.contains('clouds')) {
          backgroundImage = 'assets/cloudy.jpg';
        } else {
          backgroundImage = 'assets/default.jpg';
        }
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
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/profile.png',
                width: 40,
                height: 40,
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
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
              ),
            ),
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.white),
              onPressed: fetchCurrentWeather,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : currentWeather == null
          ? const Center(child: Text("Không thể tải dữ liệu thời tiết."))
          : Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
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
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              Text(
                DateFormat('dd MMMM yyyy').format(DateTime.now()),
                style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),
              Container(
                width: size.width,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent.withOpacity(0.8), Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
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
                        style: GoogleFonts.poppins(
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          NextHourScreen(cityName: location),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.lightBlueAccent],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Dự báo thời tiết giờ tiếp theo",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}