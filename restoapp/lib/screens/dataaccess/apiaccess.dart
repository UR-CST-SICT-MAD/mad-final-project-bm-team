// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';

// Future<District> fetchDistrict() async {
//   final response = await http.get(
//     Uri.parse('https://rw-restaurants-api.herokuapp.com/districts/'),

// // Sending authorization headers to the backend.
// headers: {
//   HttpHeaders.authorizationHeader:
//       'Token 94eab566894d7b1ac92817b63efb744c60fc4baa',
//     },
//   );
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return District.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// class District {
//   final String name;

//   District({
//     required this.name,
//   });

//   factory District.fromJson(Map<String, dynamic> json) {
//     return District(
//       name: json['Name'],
//     );
//   }
// }

// class ApiDistrict extends StatefulWidget {
//   const ApiDistrict({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<ApiDistrict> {
//   late Future<District> futureDistrict;

//   @override
//   void initState() {
//     super.initState();
//     futureDistrict = fetchDistrict();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: FutureBuilder<District>(
//         future: futureDistrict,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return Text(snapshot.data!.name);
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           }

//           // By default, show a loading spinner.
//           return const CircularProgressIndicator();
//         },
//       ),
//     );
//   }
// }

// second choice: Fetching all Districts

import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restoapp/colors.dart';
import 'package:restoapp/main.dart';
import 'package:restoapp/screens/dataaccess/dishdetails.dart';
import 'package:restoapp/screens/dataaccess/dishes.dart';
import 'package:restoapp/screens/dataaccess/restaurants.dart';
import 'package:restoapp/screens/dataaccess/sectors.dart';

List<District> postFromJson(String str) =>
    List<District>.from(json.decode(str).map((x) => District.fromMap(x)));

class District {
  District({
    required this.name,
    required this.id,
  });

  String name;
  int id;

  factory District.fromMap(Map<String, dynamic> json) => District(
        name: json["Name"],
        id: json["id"],
      );
}

// state class

Future<List<District>> fetchDistrict() async {
  final response = await http.get(
      Uri.parse(
          'https://rw-restaurants-api.herokuapp.com/districts/'), //accessing restaurant api

      // Sending authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader:
            'Token 94eab566894d7b1ac92817b63efb744c60fc4baa',
      });

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<District>((json) => District.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load Districts');
  }
}

class ApiDistrict extends StatefulWidget {
  const ApiDistrict({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ApiDistrict> {
  var distID;
  late Future<List<District>> futureDistrict;

  get listTile => null;

  @override
  void initState() {
    super.initState();
    futureDistrict = fetchDistrict();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<District>>(
        future: futureDistrict,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Container(
                  height: 60,
                  // color: backgroundcolor,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.0, color: Colors.lightBlue.shade900),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Container(
                      //   child: Image(
                      //     image: AssetImage('images/map.jpg'),
                      //     height: 30,
                      //     width: 30,
                      //   ),
                      // ),
                      SizedBox(width: 10),
                      Container(
                        width: 100,
                        child: Text(
                          "${snapshot.data![index].name}",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(left: 90),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              distID = snapshot.data![index].id;

                              print(distID);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Sectors()));
                            },
                            label: Text("View Sectors"),
                            icon: Image.asset(
                              'images/iconnext.jpg',
                              height: 20,
                              width: 20,
                            ), //icon data for elevated button

                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(buttonbackcolor),
                                textStyle: MaterialStateProperty.all(
                                  TextStyle(
                                      fontSize: 12, color: buttonfontcolor),
                                )
                                //label text
                                )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }
}

// Fetching sectors

List<Sector> sectorFromJson(String str) =>
    List<Sector>.from(json.decode(str).map((x) => Sector.fromMap(x)));

class Sector {
  Sector({required this.name, required this.districtid});

  String name;
  int districtid;

  factory Sector.fromMap(Map<String, dynamic> json) =>
      Sector(name: json["Name"], districtid: json["District"]);
}

// state class

Future<List<Sector>> fetchSector() async {
  final response = await http.get(
      Uri.parse(
          'https://rw-restaurants-api.herokuapp.com/sectors/'), //accessing restaurant api

      // Sending authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader:
            'Token 94eab566894d7b1ac92817b63efb744c60fc4baa',
      });

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Sector>((json) => Sector.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load Districts');
  }
}

class ApiSector extends StatefulWidget {
  const ApiSector({Key? key}) : super(key: key);

  @override
  _SectorState createState() => _SectorState();
}

class _SectorState extends State<ApiSector> {
  var dictrictID;
  late Future<List<Sector>> futureSector;

  get listTile => null;

  @override
  void initState() {
    super.initState();
    futureSector = fetchSector();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sector>>(
        future: futureSector,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.0, color: Colors.lightBlue.shade900),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Container(
                      //   child: Image(
                      //     image: AssetImage('images/map.jpg'),
                      //     height: 30,
                      //     width: 30,
                      //   ),
                      // ),

                      SizedBox(width: 20),
                      Container(
                        width: 130,
                        child: Text(
                          "${snapshot.data![index].name}",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(left: 100),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              dictrictID = snapshot.data![index].districtid;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Restaurants()));
                            },
                            label: Text("Restaurant"),
                            icon: Image.asset(
                              'images/iconnext.jpg',
                              height: 20,
                              width: 20,
                            ), //icon data for elevated button

                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(buttonbackcolor),
                                textStyle: MaterialStateProperty.all(
                                  TextStyle(
                                      fontSize: 15, color: buttonfontcolor),
                                )
                                //label text
                                )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }
}

//Fetching all Restaurants

List<Restaurant> restaurantFromJson(String str) =>
    List<Restaurant>.from(json.decode(str).map((x) => Restaurant.fromMap(x)));

class Restaurant {
  Restaurant({
    required this.name,
    // required this.rate,
  });

  String name;
  // double rate;

  factory Restaurant.fromMap(Map<String, dynamic> json) => Restaurant(
        name: json["Name"],
      );
}

// state class

Future<List<Restaurant>> fetchRestaurant() async {
  final response = await http.get(
      Uri.parse(
          'https://rw-restaurants-api.herokuapp.com/restaurants/'), //accessing restaurant api

      // Sending authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader:
            'Token 94eab566894d7b1ac92817b63efb744c60fc4baa',
      });

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Restaurant>((json) => Restaurant.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load Restaurant');
  }
}

class ApiRestaurant extends StatefulWidget {
  const ApiRestaurant({Key? key}) : super(key: key);

  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<ApiRestaurant> {
  late Future<List<Restaurant>> futureRestaurant;

  get listTile => null;

  @override
  void initState() {
    super.initState();
    futureRestaurant = fetchRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
        future: futureRestaurant,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Container(
                  height: 60,
                  // color: backgroundcolor,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.0, color: Colors.lightBlue.shade900),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: Image(
                          image: AssetImage('images/restaurant.png'),
                          height: 30,
                          width: 30,
                        ),
                      ),
                      SizedBox(width: 3),
                      Container(
                        width: 100,
                        child: Text(
                          "${snapshot.data![index].name}",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(left: 100),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dishes()));
                            },
                            label: Text("View Dishes"),
                            icon: Image.asset(
                              'images/iconnext.jpg',
                              height: 20,
                              width: 20,
                            ), //icon data for elevated button

                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(buttonbackcolor),
                                textStyle: MaterialStateProperty.all(
                                  TextStyle(
                                      fontSize: 15, color: buttonfontcolor),
                                )
                                //label text
                                )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }
}

// Fetching all dishes

List<Dish> dishFromJson(String str) =>
    List<Dish>.from(json.decode(str).map((x) => Dish.fromMap(x)));

class Dish {
  Dish({
    required this.name,
    required this.amount,
  });

  String name;
  String amount;

  factory Dish.fromMap(Map<String, dynamic> json) =>
      Dish(name: json["Name"], amount: json["Price"]);
}

// state class

Future<List<Dish>> fetchDish() async {
  final response = await http.get(
      Uri.parse(
          'https://rw-restaurants-api.herokuapp.com/dish/'), //accessing restaurant api

      // Sending authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader:
            'Token 94eab566894d7b1ac92817b63efb744c60fc4baa',
      });

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Dish>((json) => Dish.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load Restaurant');
  }
}

class ApiDish extends StatefulWidget {
  const ApiDish({Key? key}) : super(key: key);

  @override
  _DishState createState() => _DishState();
}

class _DishState extends State<ApiDish> {
  var index;
  late Future<List<Dish>> futureDish;

  get listTile => null;

  @override
  void initState() {
    super.initState();
    futureDish = fetchDish();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Dish>>(
        future: futureDish,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 4,
                  crossAxisCount: 4,
                  childAspectRatio: 8.0 / 8.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Padding(
                      padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dishes()));
                        },
                        child: Card(
                          elevation: 30.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              children: <Widget>[
                                AspectRatio(
                                  aspectRatio: 18.0 / 11.0,
                                  child: Image(
                                    image: AssetImage('images/burger.png'),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "${snapshot.data![index].name}",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }
}

// Fetching Dish1

List<Dish1> dish1FromJson(String str) =>
    List<Dish1>.from(json.decode(str).map((x) => Dish1.fromMap(x)));

class Dish1 {
  Dish1({
    required this.name,
    required this.amount,
  });

  String name;
  String amount;

  factory Dish1.fromMap(Map<String, dynamic> json) =>
      Dish1(name: json["Name"], amount: json["Price"]);
}

// state class

Future<List<Dish1>> fetchDish1() async {
  final response = await http.get(
      Uri.parse(
          'https://rw-restaurants-api.herokuapp.com/dish/1'), //accessing restaurant api

      // Sending authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader:
            'Token 94eab566894d7b1ac92817b63efb744c60fc4baa',
      });

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Dish1>((json) => Dish1.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load Restaurant');
  }
}

class ApiDish1 extends StatefulWidget {
  const ApiDish1({Key? key}) : super(key: key);

  @override
  _Dish1State createState() => _Dish1State();
}

class _Dish1State extends State<ApiDish1> {
  var index;
  late Future<List<Dish1>> futureDish1;

  get listTile => null;

  @override
  void initState() {
    super.initState();
    futureDish1 = fetchDish1();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Dish1>>(
        future: futureDish1,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 4,
                  crossAxisCount: 4,
                  childAspectRatio: 8.0 / 8.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Padding(
                      padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dishdetails()));
                        },
                        child: Card(
                          elevation: 30.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              children: <Widget>[
                                AspectRatio(
                                  aspectRatio: 18.0 / 11.0,
                                  child: Image(
                                    image: AssetImage('images/burger.png'),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "${snapshot.data![index].name}",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }
}
