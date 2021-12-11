import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_location_gmap/fire.dart';
import 'package:flutter_live_location_gmap/tourinfo.dart';

class Clientresult extends StatefulWidget {
  final String userid;
  final String from;
  final String to;
  final List<String> names;

  const Clientresult({Key key, this.userid, this.from, this.to, this.names})
      : super(key: key);

  @override
  _ClientresultState createState() => _ClientresultState();
}

class _ClientresultState extends State<Clientresult> {
  @override
  String dit;
  int number;
  var tourlist = [];
  QuerySnapshot q;
  void initState() {}

  var fireit = FirebaseFirestore.instance
      .collection('info')
      .where('from', isEqualTo: "cairo")
      .where('status', isEqualTo: "running")
      .get();

  var cc = FirebaseFirestore.instance.collection('info').snapshots();
  Stream<QuerySnapshot> ss() async* {
    await FirebaseFirestore.instance
        .collection('info')
        .where('from', isEqualTo: widget.from)
        .where('to', isEqualTo: widget.to)
        .where('status', isEqualTo: "running")
        .get()
        .then((querySnapshot) {
      q = querySnapshot;
    });
    yield q;
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
                StreamBuilder<QuerySnapshot>(
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
                            RaisedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(snapshot.data.docs[index]["from"]
                                        .toString()),
                                    Text("to"),
                                    Text(snapshot.data.docs[index]["to"]),
                                    Text(snapshot.data.docs[index]["status"]),
                                  ],
                                ),
                                onPressed: () {
                                  final Timestamp timestamp = snapshot.data
                                      .docs[index]["datetime"] as Timestamp;
                                  final DateTime dateTime = timestamp.toDate();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Tourinfo(
                                              id: snapshot
                                                  .data.docs[index]["tid"]
                                                  .toString(),
                                              userid: widget.userid,
                                              drivername: snapshot.data
                                                  .docs[index]["full_name"],
                                              from: snapshot.data.docs[index]
                                                  ["from"],
                                              to: snapshot.data.docs[index]
                                                  ["to"],
                                              status: snapshot.data.docs[index]
                                                  ["status"],
                                              time: dateTime.toString(),
                                            )),
                                  );
                                })
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            )),
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';


class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: "وصلنى",
      home: Container(decoration: BoxDecoration(
        image:DecorationImage(
           image: AssetImage("images/back.png"),
      fit: BoxFit.cover),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
        appBar: AppBar(title: SizedBox(
          width:double.infinity,
          child: Text("وصلنى", textDirection: TextDirection.rtl,
          textAlign: TextAlign.right ,
          style: TextStyle(color: Colors.deepPurple),),

         ),
         backgroundColor: Colors.white,
         ),
         body:  Container(child: Column(children: <Widget>[
        Container(height: 70,

           child: Stack(children: <Widget>[
             Positioned(child: Container(
               child: Center(
                 child:Center(
                   child: Text('Making order.... ',
                   style: TextStyle(
                     color: Colors.deepPurple,
                     fontSize: 30,

                ),
                   ),
                 ),
                 ),
              )

              )
           ],),
        ),
        Padding(padding: EdgeInsets.all(20.0),
        child:
        Column(children: <Widget>[
          Container(
            padding:EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:Colors.transparent,
              borderRadius: BorderRadius.circular(5),
            ),
            child:
            Column(
              children: <Widget>[
                Container(
                  padding:EdgeInsets.all(10.0),
                  decoration: BoxDecoration(

                  ),
              child: TextField(
                decoration: InputDecoration(hintText: "from",
                hintStyle: TextStyle(
                color: Colors.grey)

              ),),

                ),
                Container(
                  padding:EdgeInsets.all(10.0),
                  decoration: BoxDecoration(

                  ),
              child: TextField(
                decoration: InputDecoration(hintText: "to",
                hintStyle: TextStyle(
                color: Colors.grey)

              ),),

                ),


              ],
            )
          )

        ],
        ),

        ),
       Container(  margin: const EdgeInsets.only(left: 150,top: 200), child:  Row(children: <Widget>[
            Container(


                    child:

                    RaisedButton(onPressed: (){

                    },
                    // margin: const EdgeInsets.only(top: 10.0),
                     padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                    child:
                     Text('Search ...',

                    style: TextStyle(

                    color: Colors.white,
                    fontSize: 20,
                    ),),
                     shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                     // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),),
                      color: Colors.deepPurple,
                     // margin: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                     )


                  )]))
      ],),),
      )


      ,),

    );




  }

 */
/*
ListView(
      children: [
        Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: Fire().tourlist.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {},
                  title: Text(Fire().tourlist[index]),
                );
              },
            )
          ],
        ),
      ],
    );
 */
