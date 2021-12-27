import 'package:flutter/material.dart';
// import 'package:restoapp/colors.dart';
import 'package:restoapp/screens/components/body.dart';
import 'package:restoapp/screens/dataaccess/districts.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Body());
  }
}
