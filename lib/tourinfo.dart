import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_location_gmap/clientmap.dart';
import 'package:flutter_live_location_gmap/location_map.dart';
import 'package:flutter_live_location_gmap/payment/paymentstack.dart';
import 'package:flutter_live_location_gmap/test.dart';

class Tourinfo extends StatefulWidget {
  final String id;
  final String userid;
  final String drivername;
  final String status;
  final String time;
  final String from;
  final String to;

  const Tourinfo(
      {Key key,
      this.id,
      this.userid,
      this.drivername,
      this.status,
      this.time,
      this.from,
      this.to})
      : super(key: key);

  @override
  _TourinfoState createState() => _TourinfoState();
}

class _TourinfoState extends State<Tourinfo> {
  String tid;

  dynamic sds() {
    return FirebaseFirestore.instance.collection('info').get().asStream();
  }

  getdoc() async {
    await FirebaseFirestore.instance
        .collection('info')
        .where('tid', isEqualTo: widget.id)
        .get()
        .then((querySnapshot) {
      //number of passenger

      querySnapshot.docs.forEach((element) {
        int n;
        n = element.get("numberofusers");
        FirebaseFirestore.instance.collection('info').doc(element.id).update({
          "uid$n": widget.userid,
          "numberofusers": n + 1
        }); //update num of passenger , user id
      });
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
            body: ListView(
              children: [
                Text("driver name:${widget.drivername}"),
                Text("from:${widget.from}"),
                Text("to:${widget.to}"),
                Text("status:${widget.status}"),
                Text("time:${widget.time}"),
                RaisedButton(
                  child: Text("showlocation "),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Clientmap(
                                tourid: widget.id,
                              )),
                    );
                  },
                ),
                RaisedButton(
                  child: Text("add me to tour "),
                  onPressed: () {
                    getdoc();
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('info'),
                        content:
                            const Text('You have been added successfully '),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text("pay now "),
                  onPressed: () {
                    Makepayment(
                            ctx: context,
                            price: 100,
                            email: "mostafamousa89@yahoo.com")
                        .Chargecard();
                  },
                )
              ],
            )),
      ),
    );
  }
}
