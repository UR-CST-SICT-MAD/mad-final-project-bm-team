import 'package:flutter/material.dart';
import 'package:restoapp/colors.dart';
import 'package:restoapp/screens/components/background.dart';
import 'package:restoapp/screens/authenticate/login.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // providing us total height and width of our screen

    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 50),
            child: Image(
              image: AssetImage('images/homeicon.png'),
              height: size.height * 0.2,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 0),
            child: Text(
              "WELCOME TO RESTO APP",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: titlecolor,
                  decoration: TextDecoration.none),
            ),
          ),
          SizedBox(
            height: 10,
            width: 10,
          ),
          Container(
            width: size.height * 0.5,
            padding: EdgeInsets.only(bottom: 50),
            child: Text(
              "you are most welcome to this app where you can find restaurant",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: fontcolor,
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),

          //row 1
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 100),
                child: Text(
                  "ABOUT US",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: titlecolor),
                ),
              ),
              SizedBox(
                width: 150,
              ),
              Container(
                child: Text(
                  "SERVICES",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: titlecolor),
                ),
              ),
            ],
          ),

          //Row 2
          Row(
            children: [
              Container(
                width: 220,
                padding: EdgeInsets.only(left: 50),
                child: Text(
                  "we intended to give you option of navigating through all restaurant",
                  style: TextStyle(color: fontcolor, fontSize: 12),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Container(
                width: 200,
                child: Text(
                  "we intended to give you option of navigating through all restaurant",
                  style: TextStyle(color: fontcolor, fontSize: 12),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 70,
          ),
          Container(
            child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
                label: Text("GET STARTED"),
                icon: Image.asset(
                  'images/iconnext.jpg',
                  height: 20,
                  width: 20,
                ), //icon data for elevated button

                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(buttonbackcolor),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 15, color: buttonfontcolor),
                    )
                    //label text
                    )),
          ),
          //next button
        ],
      ),
    );
  }
}
