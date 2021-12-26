import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restoapp/colors.dart';
import 'package:restoapp/screens/authenticate/register.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final auth = FirebaseAuth.instance;
  String _emailcontroller = TextEditingController().text;
  String _passwordController = TextEditingController().text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Back',
            style: TextStyle(fontWeight: FontWeight.bold, color: appbarcolor),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Image(
                      image: AssetImage('images/profile.jpg'),
                      height: 80,
                      width: 80,
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 25),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    // controller: _emailcontroller,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    onChanged: (value) {
                      _emailcontroller = value.trim();
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    // controller: _passwordController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    onChanged: (value) {
                      _passwordController = value.trim();
                    },
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.blue,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(90, 0, 90, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.blue)))),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        auth.signInWithEmailAndPassword(
                            email: _emailcontroller,
                            password: _passwordController);
                        print(_emailcontroller);
                        print(_passwordController);
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
