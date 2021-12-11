import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_location_gmap/driverview.dart';
import 'package:flutter_live_location_gmap/profiledriver.dart';
import 'package:flutter_live_location_gmap/signup_driver.dart';

class Logindriver extends StatefulWidget {
  @override
  _LogindriverState createState() => _LogindriverState();
}

class _LogindriverState extends State<Logindriver> {
  final emailcon = TextEditingController();
  final passwordcon = TextEditingController();
  bool error = false;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String uid;
  String drivername;
  getname() async {
    await FirebaseFirestore.instance
        .collection('info')
        .where('did', isEqualTo: uid)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        drivername = element.get("full_name");
        print(drivername);
      });
    });
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
                        onPressed: () {
                          if (_key.currentState.validate()) {
                            try {
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailcon.text,
                                      password: passwordcon.text)
                                  .catchError((err) {
                                error = true;
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
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
                                        builder: (context) => Driverprof(
                                              drivername: "sasa",
                                              driverid: uid,
                                            )),
                                  );
                                }
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        label: Text("login")),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => signupdriver()),
                        );
                      },
                      child: new Text(
                        "sign up",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    )
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
