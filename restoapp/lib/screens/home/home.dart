import 'package:flutter/material.dart';
import 'package:restoapp/colors.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundcolor,
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.only(top: 100),
              child: Image(
                image: AssetImage('images/homeicon.png'),
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Welcome to RestoAPP!",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
              ),
            ),
            Row(
              children: [
                Text("ABOUT US"),
                Container(
                  child: Text("This RestoAPP"),
                ),
                Text("SERVICES"),
                Container(
                  child: Text("This RestoAPP"),
                ),
              ],
            ),
          ],
        ));
  }
}
