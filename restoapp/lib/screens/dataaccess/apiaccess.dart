// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;

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

// second choice

import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restoapp/colors.dart';
import 'package:restoapp/screens/dataaccess/sectors.dart';

List<District> postFromJson(String str) =>
    List<District>.from(json.decode(str).map((x) => District.fromMap(x)));

class District {
  District({
    required this.name,
  });

  String name;

  factory District.fromMap(Map<String, dynamic> json) => District(
        name: json["Name"],
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
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ApiDistrict> {
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
                  // autofocus: true,
                  // // leading: Image(
                  // //   image: AssetImage('images/map.jpg'),
                  // //   height: 30,
                  // //   width: 30,
                  // // ),
                  // title:

                  color: backgroundcolor,
                  child: Row(
                    children: [
                      Container(
                        child: Image(
                          image: AssetImage('images/map.jpg'),
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
                                      fontSize: 15, color: buttonfontcolor),
                                )
                                //label text
                                )),
                      ),
                    ],
                  ),
                ),
              ),

              // trailing: ElevatedButton.icon(
              //   onPressed: () {
              //     // getDistricts();

              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => Sectors()));
              //   },
              //   label: Text("View Sectors"),
              //   icon: Image.asset(
              //     'images/iconnext.jpg',
              //     height: 20,
              //     width: 20,
              //   ), //icon data for elevated button

              //   style: ButtonStyle(
              //       // backgroundColor:
              //       //     MaterialStateProperty.all(buttonbackcolor),
              //       // textStyle: MaterialStateProperty.all(
              //       //   TextStyle(fontSize: 15, color: buttonfontcolor),
              //       // )
              //       // //label text
              //       // )
              //       // ),
              //       ),
              // )
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }
}
