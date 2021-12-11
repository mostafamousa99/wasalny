import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_location_gmap/loginclient.dart';
import 'package:flutter_live_location_gmap/logindriver.dart';
import 'package:flutter_live_location_gmap/payment/paymentstack.dart';
import 'package:flutter_live_location_gmap/signup_client.dart';
import 'package:flutter_live_location_gmap/signup_driver.dart';
import 'package:flutter_live_location_gmap/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class dr extends StatelessWidget {
  getdoc() async {
    await FirebaseFirestore.instance
        .collection('info')
        .where('ss', isEqualTo: "sdsds")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element.get("nn"));
      });
    });
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FloatingActionButton.extended(
                heroTag: "btn1",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Logindriver()),
                  );
                  //Makepayment(
                  //      ctx: context,
                  //    price: 100,
                  //  email: "mostafamousa89@yahoo.com")
                  //.Chargecard();
                },
                label: Text(
                  "Driver",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              FloatingActionButton.extended(
                heroTag: "btn2",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => login()),
                  );
                },
                label: Text("client", style: TextStyle(fontSize: 30)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
