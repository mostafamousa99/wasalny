import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_location_gmap/driverview.dart';

class Driverprof extends StatefulWidget {
  final String drivername;
  final String driverid;

  const Driverprof({Key key, this.drivername, this.driverid}) : super(key: key);

  @override
  _DriverprofState createState() => _DriverprofState();
}

class _DriverprofState extends State<Driverprof> {
  QuerySnapshot q;

  /*Stream<QuerySnapshot> ss() async* {
    await FirebaseFirestore.instance
        .collection('info')
        .where('userid', isEqualTo: widget.userid)
        .get()
        .then((querySnapshot) {
      q = querySnapshot;
    });
    yield q;
  }*/

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
              CircleAvatar(
                child: Image.asset(
                  "assets/use.png",
                  fit: BoxFit.cover,
                  //width: 50.0,
                  //height: 150.0,
                ),
                backgroundColor: Colors.transparent,
                radius: 50,
              ),
              Center(
                child: Text(
                  widget.drivername,
                  style: TextStyle(
                    color: Colors.indigoAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              RaisedButton(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text("take a ride !"),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Avl_driver(
                                drivername: widget.drivername,
                                driverid: widget.driverid,
                              )),
                    );
                  }),
              /*StreamBuilder<QuerySnapshot>(
                stream: ss(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Text(
                              snapshot.data.docs[index]["full_name"].toString(),
                              style: TextStyle(
                                color: Colors.indigoAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          RaisedButton(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text("take a ride !"),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Avl_driver(
                                            drivername: snapshot
                                                .data.docs[index]["full_name"]
                                                .toString(),
                                            driverid: snapshot
                                                .data.docs[index]["did"]
                                                .toString(),
                                          )),
                                );
                              })
                        ],
                      );
                    },
                  );
                },
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
