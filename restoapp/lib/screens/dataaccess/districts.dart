import 'dart:convert';
import 'dart:io';
import 'package:flutter/src/rendering/box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restoapp/colors.dart';
import 'package:restoapp/main.dart';
import 'package:restoapp/models/user.dart';
import 'package:restoapp/screens/components/bottomnavigators/profile.dart';
import 'package:restoapp/screens/dataaccess/apiaccess.dart';
import 'package:restoapp/screens/dataaccess/sectors.dart';
import 'package:http/http.dart' as http;

class Districts extends StatefulWidget {
  const Districts({Key? key}) : super(key: key);

  @override
  _DistrictsState createState() => _DistrictsState();
}

class _DistrictsState extends State<Districts> {
//function to get data from API

  // final String url = "https://rw-restaurants-api.herokuapp.com/districts/";
  // List data;

  // @override
  // void initState() {
  //   // super.initState();
  //   this.getJesonData();
  // }

  // FU
  //using the second resources

//using loop for accessing list of the items from api
  // getDistricts() async {
  //   final response = await http
  //       .get(Uri.parse('https://rw-restaurants-api.herokuapp.com/districts/'),
  //           // Send authorization headers to the backend.
  //           headers: {
  //         HttpHeaders.authorizationHeader:
  //             'Token 94eab566894d7b1ac92817b63efb744c60fc4baa'
  //       });
  //   var jsonData = jsonDecode(response.body);

  //   List<District> districts = [];

  //   for (var u in jsonData) {
  //     District district = District(u["name"]);

  //     //adding value into a list
  //     districts.add(district);
  //   }
  //   print(districts.length);
  //   return districts;
  // }

//getting information from current user
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  final List<String> districts = <String>['Rwamagana', 'Musanze', 'Muhanga'];
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text('Districts of Rwanda');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: customSearchBar,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {/* Write listener code here */},
          child: Icon(
            Icons.menu, // add custom icons also
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {},

                  //TODO: searching district displayed on screen
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (customIcon.icon == Icons.search) {
                          // Perform set of instructions.
                          customIcon = const Icon(Icons.cancel);
                          customSearchBar = const ListTile(
                            leading: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 28,
                            ),
                            title: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search a district...',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else {
                          customIcon = const Icon(Icons.search);
                          customSearchBar = const Text('Districts of Rwanda');
                        }
                      });
                    },
                    icon: customIcon,
                  ))),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTapDown: (TapDownDetails details) {
                  _showPopupMenu(details.globalPosition);
                },
                child: Container(child: Icon(Icons.more_vert)),
              )),
        ],
      ),
      body: ApiDistrict(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black12,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Districts())),
              child: Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile())),
              child: Icon(
                Icons.account_circle_outlined,
                color: Colors.black,
              ),
            ),
            label: '${loggedInUser.username}',
          ),
        ],
      ),
    );
  }

  void _showPopupMenu(Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 100),
      items: [
        PopupMenuItem(
          value: 1,
          child: Text("View"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("Edit"),
        ),
        PopupMenuItem(
          onTap: () {
            logout(context);
          },
          value: 3,
          child: Text("Delete"),
        ),
        PopupMenuItem(
          value: 3,
          child: Text("Logout"),
          onTap: () => logout(context),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
// NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null

      if (value != null) print(value);
    });
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
  }
}

// class for fetching all the districts from the API

// class District {
//   final String name;
//   District(this.name);
// }
