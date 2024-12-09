import 'package:flutter/material.dart';
import 'package:weather_app/models/city.dart';

import 'home.dart';

class SelectCity extends StatefulWidget {
  const SelectCity({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SelectCity();
  }
}

class _SelectCity extends State<SelectCity>{

  String _searchText = "";
  List<City> cities = City.citiesList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Text(
              "Select Cities",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Spacer(),
          ],
        ),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
              // Navigator.pushReplacement(context, MaterialPageRoute(
              // builder: (context) => const Home()));
              
              // List<City> list = CityAPI.getSelectedCities();
              // for (City city in list){
              //   print(city.name);
              // }
            },
            child: const Text("Next",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (text){
                setState(() {
                _searchText = text;
                });
              },
              decoration: const InputDecoration(
                hintText: "Input city name",
                hintStyle: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Arial'
                ),
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.pinkAccent,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCities.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  // width: size.width * 0.8,
                  child: Container(
                    height: size.height/15,
                    margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 190, 190, 190),
                      borderRadius: BorderRadius.circular(10),
                      border: cities[index].isSelected == true ? Border.all(
                        color: Colors.lightBlue, width: 3)
                          : Border.all(color: Colors.yellow),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ]
                    ),
                    child: ListTile(
                      // contentPadding: const EdgeInsets.only(bottom:10),
                      leading: GestureDetector(
                        onTap: (){
                          setState(() {
                            cities[index].isSelected =! cities[index].isSelected;
                          });
                        },
                        child: Image.asset(cities[index].isSelected == true ?
                        'assets/checked.png' : 'assets/unchecked.png', width: 30,
                        ),
                        // const SizedBox(width: 20,)
                      ),
                      title: Text(filteredCities[index].name,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<City> get filteredCities {
    if (_searchText.isEmpty) {
      return cities;
    } else {
      return cities.where((city) => city.name.toLowerCase().contains(_searchText.toLowerCase())).toList();
    }
  }
}