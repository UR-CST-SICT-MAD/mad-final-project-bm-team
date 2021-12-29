import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restoapp/colors.dart';
import 'package:restoapp/main.dart';
import 'package:restoapp/models/user.dart';
import 'package:restoapp/screens/dataaccess/districts.dart';
import 'package:restoapp/screens/dataaccess/sectors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _DistrictsState createState() => _DistrictsState();
}

class _DistrictsState extends State<Profile> {
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
                onTapDown: (TapDownDetails details) {
                  _showPopupMenu(details.globalPosition);
                },
                child: Container(child: Icon(Icons.more_vert)),
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 200, 50, 0),
        child: ListView.separated(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                color: Colors.white,
                elevation: 100,
                shadowColor: Colors.black,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: Column(
                      children: [
                        Container(
                          // padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
                          child: Text(
                            "Your Personal Information",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Text("First Name: ${loggedInUser.secondname}"),
                        ),
                        SizedBox(height: 7),
                        Container(
                          child: Text("Last Name: ${loggedInUser.firstname}"),
                        ),
                        SizedBox(height: 7),
                        Container(
                          child: Text("User Name: ${loggedInUser.username}"),
                        ),
                        SizedBox(height: 7),
                        Container(
                          child: Text("Email: ${loggedInUser.email}"),
                        ),
                        SizedBox(height: 7),
                      ],
                    ))));
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 0,
          ),
        ),
      ),
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
            icon: Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
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
