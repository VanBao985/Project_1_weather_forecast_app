import 'package:flutter/material.dart';

class DetailNextHour extends StatefulWidget {
  final String location;
  final int selectedId;
  const DetailNextHour({Key? key, required this.location, required this.selectedId}) : super(key: key);

  @override
  State<DetailNextHour> createState() => _DetailNextHourState();
}

class _DetailNextHourState extends State<DetailNextHour> {
  late String location;
  late int selectedId;

  @override
  Widget build(BuildContext context) {
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
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        )
    );
  }
}