import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_location_gmap/clientview.dart';
import 'package:flutter_live_location_gmap/driverview.dart';
import 'package:flutter_live_location_gmap/profileclient.dart';
import 'package:flutter_live_location_gmap/signup_client.dart';

class login extends StatelessWidget {
  final emailcon = TextEditingController();
  final passwordcon = TextEditingController();
  String uid;
  bool error = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
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
                      "login",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: TextFormField(
                        validator: ValidateEmail,
                        controller: emailcon,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue,
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0),
                            ),
                          ),
                          hintText: "email",
                          icon: Icon(
                            Icons.verified_user,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
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
                              const Radius.circular(50.0),
                            ),
                          ),
                          hintText: "password",
                          icon: Icon(
                            Icons.lock,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FloatingActionButton.extended(
                      onPressed: () async {
                        if (_key.currentState.validate()) {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailcon.text,
                                    password: passwordcon.text)
                                .catchError((err) {
                              error = true;
                              print(err);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('error'),
                                  content:
                                      const Text('please check your input '),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            });
                            if (FirebaseAuth.instance.currentUser != null) {
                              uid = FirebaseAuth.instance.currentUser.uid;
                              if (error == false) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Clientprof(
                                            userid: uid,
                                          )),
                                );
                              }
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      label: Text("login"),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Signupclient()),
                        );
                      },
                      child: new Text(
                        "sign up",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
