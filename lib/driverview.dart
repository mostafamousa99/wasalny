import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_location_gmap/d_r.dart';
import 'package:flutter_live_location_gmap/test.dart';
import 'signup_driver.dart';

class Avl_driver extends StatefulWidget {
  final String drivername;
  final String driverid;

  const Avl_driver({Key key, this.drivername, this.driverid}) : super(key: key);

  @override
  _Avl_driverState createState() => _Avl_driverState();
}

class _Avl_driverState extends State<Avl_driver> {
  String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  String tourid;
  Random _rnd = Random();
  var now = DateTime.now();

  TextEditingController _controller;
  TextEditingController _controller2;
  String con1;
  String con2;
  bool pressAttention = false;
  int num = 200;
  CollectionReference users = FirebaseFirestore.instance.collection('info');

  var list = ['cairo', 'alex', 'sirs', 'menof', 'shibin'];
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> addUser() {
    return users.doc("$tourid").set({
      'full_name': widget.drivername,
      "tid": tourid,
      "did": widget.driverid,
      "about": "$con1 to $con2 available",
      "from": _controller.text,
      "to": _controller2.text,
      "datetime": now,
      "driverlocation": GeoPoint(30.440845849088838, 30.960915999999997),
      "uid1": "",
      "uid2": "",
      "uid3": "",
      "uid4": "",
      "uid5": "",
      "uid6": "",
      "uid7": "",
      "uid8": "",
      "uid9": "",
      "uid10": "",
      "uid11": "",
      "uid12": "",
      "numberofusers": 1,
      "status": "running"
    });
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              _controller.text = list[index];
              con1 = _controller.text;
            },
            title: Text(list[index]),
          );
        },
      ),
    );
  }

  Widget setupAlertDialoadContainer2() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              _controller2.text = list[index];
              con2 = _controller2.text;
            },
            title: Text(list[index]),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = new TextEditingController(text: "from");
    _controller2 = new TextEditingController(text: "to");
  }

  @override
  Widget build(BuildContext context) {
    bool switchstate1 = false;
    bool switchstatet2 = true;
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
                                'Driver ',
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
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Container(
                              child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(),
                                child: TextField(
                                  controller: _controller,
                                  onTap: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('AlertDialog Title'),
                                      content: setupAlertDialoadContainer(),
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
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(),
                                child: TextField(
                                  controller: _controller2,
                                  onTap: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('AlertDialog Title'),
                                      content: setupAlertDialoadContainer2(),
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
                                  ),
                                ),
                              ),
                            ],
                          ))
                        ],
                      )),
                ],
              ),
              RaisedButton(
                color: pressAttention ? Colors.green : Colors.grey,
                onPressed: () {
                  tourid = getRandomString(15);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Test(
                              tourid: tourid,
                            )),
                  );

                  addUser();
                  setState(() {
                    pressAttention = !pressAttention;
                  });
                },
                // margin: const EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'available',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
