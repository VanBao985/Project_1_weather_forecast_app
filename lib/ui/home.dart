import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/widgets/weather_item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Constants myConstants = Constants();

  // Dữ liệu mặc định
  int temperature = 40; // Nhiệt độ mặc định
  int maxTemp = 40; // Nhiệt độ cao nhất mặc định
  String weatherStateName = 'Mưa nhẹ'; // Tên trạng thái thời tiết mặc định
  int humidity = 60; // Độ ẩm mặc định
  int windSpeed = 15; // Tốc độ gió mặc định

  var currentDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  String imageUrl = 'heavyrain'; // Ảnh thời tiết mặc định
  String location = 'Hà Nội'; // Vị trí mặc định

  // Danh sách các thành phố (có thể mở rộng sau)
  List<String> cities = ['Hà Nội', 'Phú Thọ'];

  // Định nghĩa lại Shader linearGradient
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width,100), // Đặt chiều cao của AppBar
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.png'), // Đường dẫn tới ảnh nền
                  fit: BoxFit.cover, // Đảm bảo ảnh bao phủ toàn bộ chiều rộng
                ),
              ),
            ),
            Container(
              width: size.width,
              height: 100,
              color: Colors.white.withOpacity(0), // Thêm lớp màu trong suốt với độ mờ
            ),
            // Các widget trong AppBar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: size.width,

              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  // Ảnh đại diện
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(
                      'assets/profile.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  // Dropdown chọn vị trí
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/pin.png',
                        width: 20,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: location,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: cities.map((String location) {
                              return DropdownMenuItem(
                                  value: location, child: Text(location));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                location = newValue!;
                              });
                            }),
                      ),
                    ],
                  ),
                ],



              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'), // Đường dẫn tới ảnh nền
            fit: BoxFit.cover, // Đảm bảo ảnh bao phủ toàn bộ màn hình
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
                currentDate,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: size.width,
                height: 200,
                decoration: BoxDecoration(
                    color: myConstants.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: myConstants.primaryColor.withOpacity(.5),
                        offset: const Offset(0, 25),
                        blurRadius: 10,
                        spreadRadius: -12,
                      )
                    ]),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -40,
                      left: 20,
                      child: imageUrl == ''
                          ? const Text('')
                          : Image.asset(
                        'assets/' + imageUrl + '.png',
                        width: 150,
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 20,
                      child: Text(
                        weatherStateName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
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
                              temperature.toString(),
                              style: TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = linearGradient,
                              ),
                            ),
                          ),
                          Text(
                            'o',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linearGradient,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    weatherItem(
                      text: 'Tốc độ gió',
                      value: windSpeed,
                      unit: 'km/h',
                      imageUrl: 'assets/windspeed.png',
                    ),
                    weatherItem(
                      text: 'Độ ẩm',
                      value: humidity,
                      unit: '',
                      imageUrl: 'assets/humidity.png',
                    ),
                    weatherItem(
                      text: 'Nhiệt độ tối đa',
                      value: maxTemp,
                      unit: '°C',
                      imageUrl: 'assets/max-temp.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
