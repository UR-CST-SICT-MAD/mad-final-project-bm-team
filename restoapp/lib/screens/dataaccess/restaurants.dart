import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restoapp/colors.dart';
import 'package:restoapp/models/user.dart';
import 'package:restoapp/screens/authenticate/login.dart';
import 'package:restoapp/screens/dataaccess/apiaccess.dart';
import 'package:restoapp/screens/dataaccess/dishes.dart';
import 'package:restoapp/screens/dataaccess/districts.dart';
import 'package:restoapp/screens/dataaccess/sectors.dart';

class Restaurants extends StatefulWidget {
  const Restaurants({Key? key}) : super(key: key);

  @override
  _DistrictsState createState() => _DistrictsState();
}

class _DistrictsState extends State<Restaurants> {
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

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text('Restaurants');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: customSearchBar,
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {},
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
                                hintText: 'Restaurant...',
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
                          customSearchBar =
                              const Text('Restaurants in Rwamagana');
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
      body: ApiRestaurant(),
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
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Restaurants())),
              child: Icon(
                Icons.restaurant_menu_rounded,
                color: Colors.black,
              ),
            ),
            label: 'Restaurants',
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
      position: RelativeRect.fromLTRB(100, 70, 0, 100),
      items: [
        PopupMenuItem(
          child: Text("Logout", style: TextStyle(fontWeight: FontWeight.bold)),
          onTap: () => logout(context),
        ),
      ],
      elevation: 10.0,
    ).then((value) {
// NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null

      if (value != null) print(value);
    });
  }

//logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
  }
}
