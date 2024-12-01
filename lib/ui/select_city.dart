import 'package:flutter/material.dart';
import 'package:weather_app/models/city.dart';

class SelectCity extends StatefulWidget {
  const SelectCity({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SelectCity();
  }
}

class _SelectCity extends State<SelectCity>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<City> cities = City.citiesList;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Select City",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )
        ),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: const BoxDecoration(

            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){

                  },
                  child: Image.asset(cities[index].isSelected == true ?
                  'assets/checked.png' : 'assets/unchecked.png', width: 30,),
                ),
                const SizedBox(width: 20,),
                Text(cities[index].city)
              ],
            ),
          );

        },

      ),
    );
  }
}