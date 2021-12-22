import 'package:flutter/material.dart';
import 'package:restoapp/screens/components/background.dart';

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
            padding: EdgeInsets.only(bottom: 100),
            child: Image(
              image: AssetImage('images/homeicon.png'),
              height: size.height * 0.2,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 100),
            child: Text(
              "WELCOME TO RESTO APP",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 100),
                child: Text(
                  "ABOUT US",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(
                width: 150,
              ),
              Container(
                child: Text(
                  "SERVICES",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
