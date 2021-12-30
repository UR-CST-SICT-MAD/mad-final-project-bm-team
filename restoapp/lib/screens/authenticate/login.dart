import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restoapp/colors.dart';
import 'package:restoapp/screens/authenticate/register.dart';
import 'package:restoapp/screens/dataaccess/districts.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // form key
  final _formKey = GlobalKey<FormState>();

  //Editing Controller
  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

// Firebase
  final _auth = FirebaseAuth.instance;

  // string for displying error message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appbarBackGroundColor,
          title: Text(
            'Back',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),

            //starting point of the form
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  //Login icon
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Image(
                        image: AssetImage('images/profile.jpg'),
                        height: 80,
                        width: 80,
                      )),

                  //signin message
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 25),
                      )),

                  //Email TextForm
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please Enter Your Email");
                        }

                        // reg expression for email validation
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("Please Enter a valid email");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        emailcontroller.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),

                  //Password TextFormField
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      autofocus: false,
                      controller: passwordController,
                      style: TextStyle(color: Colors.black),
                      obscureText: true,
                      validator: (value) {
                        RegExp regex = new RegExp(r'^.{8,}$');
                        if (value!.isEmpty) {
                          return ("Password is required for login");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Enter Valid Password(Min. 8 Character)");
                        }
                      },
                      onSaved: (value) {
                        passwordController.text = value!;
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),

                  FlatButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    textColor: Colors.blue,
                    child: Text('Forgot Password'),
                  ),

                  //login button
                  Container(
                      decoration: BoxDecoration(),
                      height: 50,
                      padding: EdgeInsets.fromLTRB(90, 0, 90, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.blue)))),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          signIn(emailcontroller.text, passwordController.text);
                        },
                      )),

                  //sign up button
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
              ),
            )));
  }

  // function for login
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "you are now logged in the app"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Districts())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "This user doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "This user has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
