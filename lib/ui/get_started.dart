import 'package:flutter/material.dart';
import 'package:weather_app/ui/select_city.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;  // get size of screen
    return Scaffold(
      body: Container(
        // margin: const EdgeInsets.only(top: 40),
        color: Colors.blueGrey,
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(height: 30,),
                Image.asset("assets/start-app.png"),
                const SizedBox(height: 60,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context)=> const SelectCity()
                    ));
                  },
                  child: Container(
                    height: 60,
                    width: size.width * 0.5,
                    decoration: const BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Center(
                      child: Text('Start',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ),
              ],
            ),
            Positioned(
              bottom: 16,
              right:16,
              child: ElevatedButton(
                onPressed: () {
                  _showMyInfo(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(3),
                  shape: CircleBorder(),
                ),
                child: const Icon(
                  Icons.error,
                  color: Colors.blue,
                  size: 36,
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
  Future<void> _showMyInfo(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Project 1'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Ứng dụng hiển thị và dự báo thời tiết", style: TextStyle(fontSize: 15),),
                Text('Project 1 - Kỳ 2024.1', style: TextStyle(fontSize: 16),),
                Text('GVHD: TS. Nguyễn Bình Minh', style: TextStyle(fontSize: 16),)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}