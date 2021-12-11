import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_location_gmap/clientresult.dart';
import 'package:flutter_live_location_gmap/fire.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class Clientview extends StatefulWidget {
  final String clientname;
  final String userid;

  const Clientview({Key key, this.clientname, this.userid}) : super(key: key);
  @override
  _ClientviewState createState() => _ClientviewState();
}

class _ClientviewState extends State<Clientview> {
  Location _l = new Location();
  LocationData _locationData;

  TextEditingController _controller;
  TextEditingController _controller2;
  String con;
  String con2;
  List<String> tidlist = [];

  bool pressAttention = false;
  int num = 15;
  CollectionReference users = FirebaseFirestore.instance.collection('info');

  var list = ['cairo', 'alex', 'sirs', 'menof', 'shibin'];
  Future<void> getdoc() async {
    await FirebaseFirestore.instance
        .collection('info')
        .where('from', isEqualTo: "$con")
        .where('to', isEqualTo: "$con2")
        .get()
        .then((querySnapshot) {
      //number of passenger

      querySnapshot.docs.forEach((element) {
        print(element.id);
        String n;
        n = element.get("tid");
        tidlist.add(n);
        //update num of passenger , user id
      });
    });
  }

  Future<void> location() async {
    _locationData = await _l.getLocation();
    if (_locationData.latitude != null) {
      addUser();
    }
  }

  Future<void> addUser() {
    return users.doc(widget.userid).set({
      'full_name': widget.clientname,
      "uid": widget.userid,
      "location": GeoPoint(_locationData.latitude,
          _locationData.longitude) //30.440845849088838, 30.960915999999997
    });
  }

  Widget setupAlertDialoadContainer3() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: tidlist.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {},
            title: Text(tidlist[index]),
          );
        },
      ),
    );
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
              con = _controller.text;
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
                                'Client ',
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
                                          onPressed: () {
                                            Navigator.pop(context, 'OK');
                                          },
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
                  //obscureText: true,
                  //                                    obscuringCharacter: '*',getdoc();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Clientresult(
                              from: con,
                              to: con2,
                            )),
                  );
                  //getdoc();

                  //addUser();

                  setState(() {
                    pressAttention = !pressAttention;
                  });
                },
                // margin: const EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'find',
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
