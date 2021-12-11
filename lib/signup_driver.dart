import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_live_location_gmap/driverview.dart';
import 'package:flutter_live_location_gmap/profiledriver.dart';

class signupdriver extends StatelessWidget {
  final emailcon = TextEditingController();
  final usercon = TextEditingController();

  final passwordcon = TextEditingController();
  String uid;
  String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  var now = DateTime.now();
  CollectionReference users = FirebaseFirestore.instance.collection('info');
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String ValidateText(String fromtext) {
    if (fromtext.isEmpty) return "this feild is reqired";
    return null;
  }

  String ValidateEmail(String fromemail) {
    if (fromemail.isEmpty) return "this feild is reqired";
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    if (!regExp.hasMatch(fromemail)) return "invalid email";
    return null;
  }

  String Validatepasseord(String frompass) {
    if (frompass.isEmpty) return "this feild is reqired";
    if (frompass.length < 8) return "password must be more than 8 char";
    return null;
  }

  String Validatephone(String frompass) {
    if (frompass.isEmpty) return "this feild is reqired";
    if (frompass.length < 11 || frompass.length > 11)
      return "password must be 11";

    return null;
  }

  String Validateli(String fromli) {
    if (fromli.isEmpty) return "this feild is reqired";
    if (fromli.length < 14 || fromli.length > 14) return "password must be 14";

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/m.jpeg"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _key,
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "sign up",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        validator: ValidateText,
                        controller: usercon,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue,
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(25.0),
                            ),
                          ),
                          hintText: "user name",
                          icon: Icon(
                            Icons.verified_user,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        validator: ValidateEmail,
                        controller: emailcon,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue,
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(25.0),
                            ),
                          ),
                          hintText: "email",
                          icon: Icon(
                            Icons.email,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        validator: Validatepasseord,
                        obscureText: true,
                        obscuringCharacter: '*',
                        controller: passwordcon,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue,
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(25.0),
                            ),
                          ),
                          hintText: "password",
                          icon: Icon(
                            Icons.lock,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        validator: Validatephone,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue,
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(25.0),
                            ),
                          ),
                          hintText: "phone number",
                          icon: Icon(
                            Icons.phone,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        validator: Validateli,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue,
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(25.0),
                            ),
                          ),
                          hintText: "licence id",
                          icon: Icon(
                            Icons.airport_shuttle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Text(
              'Sign Up ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
            onPressed: () {
              if (_key.currentState.validate()) {
                print("okk");
                try {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailcon.text, password: passwordcon.text);
                  if (FirebaseAuth.instance.currentUser != null) {
                    uid = FirebaseAuth.instance.currentUser.uid;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Driverprof(
                                driverid: uid,
                                drivername: usercon.text,
                              )),
                    );
                  }
                } catch (e) {
                  print(e);
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
