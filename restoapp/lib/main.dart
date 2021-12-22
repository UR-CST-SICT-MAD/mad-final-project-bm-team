import 'package:flutter/material.dart';
import 'package:restoapp/colors.dart';
import 'package:restoapp/screens/wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RestoApp',
      theme: ThemeData(
        primaryColor: kprimarycolor,
        scaffoldBackgroundColor: backgroundcolor,
      ),
      home: Wrapper(),
    );
  }
}
