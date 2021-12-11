import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_live_location_gmap/fire.dart';
import 'package:flutter_live_location_gmap/profileclient.dart';
import 'package:location/location.dart';

import 'clientview.dart';

class Signupclient extends StatelessWidget {
  final emailcon = TextEditingController();
  final usercon = TextEditingController();
  final passwordcon = TextEditingController();
  Location _l = new Location();
  LocationData _locationData;
  CollectionReference users = FirebaseFirestore.instance.collection('info');

  String uid;
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

  Future<void> location() async {
    _locationData = await _l.getLocation();
    if (_locationData.latitude != null) {
      addUser();
    }
  }

  Future<void> addUser() {
    return users.doc(uid).set({
      'full_name': usercon.text,
      "userid": uid,
      "location": GeoPoint(_locationData.latitude,
          _locationData.longitude) //30.440845849088838, 30.960915999999997
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "وصلنى",
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/m.jpeg"), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: SizedBox(
              width: double.infinity,
              child: Text(
                "وصلنى",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: Form(
            key: _key,
            child: ListView(
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      height: 70,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              child: Container(
                            child: Center(
                              child: Center(
                                child: Text(
                                  'client SignUp ',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(),
                                    child: TextFormField(
                                      validator: ValidateText,
                                      controller: usercon,
                                      decoration: InputDecoration(
                                          hintText: "User name",
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(),
                                    child: TextFormField(
                                      validator: ValidateEmail,
                                      controller: emailcon,
                                      decoration: InputDecoration(
                                          hintText: "Email ",
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(),
                                    child: TextFormField(
                                      validator: Validatepasseord,
                                      controller: passwordcon,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                      obscureText: true,
                                      obscuringCharacter: '*',
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(),
                                    child: TextFormField(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: Validatephone,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: "Phone number",
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 150, top: 150),
                        child: Row(children: <Widget>[Container()]))
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
                location();
                try {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailcon.text, password: passwordcon.text);
                  if (FirebaseAuth.instance.currentUser != null) {
                    uid = FirebaseAuth.instance.currentUser.uid;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Clientprof(
                                userid: uid,
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
