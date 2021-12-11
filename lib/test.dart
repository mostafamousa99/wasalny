import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_location_gmap/driverview.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Test extends StatefulWidget {
  final String tourid;

  const Test({Key key, this.tourid}) : super(key: key);
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final String _collection = 'collectionName';
  double lat = null;
  int n = 1;
  int nn = 1;
  String uid;

  double lng = null;
  GeoPoint geoPoint;
  GeoPoint geo;
  GeoPoint ueo;

  List<Marker> mymarker = [];
  Location _location = new Location();
  LocationData _locationData;

  Position p;
  LatLng s = LatLng(35.68, 51.41);
  Future<Position> position = Geolocator.getCurrentPosition();

  GoogleMapController _controller;

  final firestoreInstance = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _onPressed() async {
    await FirebaseFirestore.instance
        .collection("info")
        .doc("lA1eeaj7B7UPTu1ZlBQU")
        .update({"mm": GeoPoint(53.483959, -2.244644)});
  }

  /*void ss() async {
    _location.getLocation();
    mymarker.add(Marker(markerId: MarkerId("1"), position: LatLng(lat, lng)));
  }*/

  Future<void> add() async {
    var l = await _location.getLocation();

    await firestoreInstance.collection("info").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        geoPoint = result.get("mm");
        setState(() {
          mymarker.add(
            Marker(
              markerId: MarkerId("2"),
              position: LatLng(
                geoPoint.latitude,
                geoPoint.longitude,
              ),
            ),
          );
        });
      });
    });
    _onPressed();
  }

  void _onmapcreated(GoogleMapController _crtl) {
    _controller = _crtl;
    _location.onLocationChanged.listen((l) {
      lat = l.latitude;
      lng = l.longitude;
      FirebaseFirestore.instance
          .collection("info")
          .doc(widget.tourid)
          .update({"driverlocation": GeoPoint(l.latitude, l.longitude)});

      FirebaseFirestore.instance.collection("info").snapshots().listen(
        (event) {
          event.docChanges.forEach((element) async {
            await FirebaseFirestore.instance
                .collection('info')
                .where('tid',
                    isEqualTo: "iS5ahpSBDEcR1MH") //متنساش تغيره لل defult
                .get()
                .then((querySnapshot) {
              querySnapshot.docs.forEach((element) {
                while (n <= 12) {
                  if (element.get("uid$n") != "") {
                    uid = element.get("uid$n");
                    FirebaseFirestore.instance
                        .collection('info')
                        .where('uid', isEqualTo: uid)
                        .get()
                        .then((querySnapshot) {
                      querySnapshot.docs.forEach((element) {
                        ueo = element.get("location");
                        setState(() {
                          mymarker.add(Marker(
                              markerId: MarkerId("$nn"),
                              infoWindow: InfoWindow.noText,
                              position: LatLng(ueo.latitude, ueo.longitude),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueCyan)));
                        });
                        nn++;
                      });
                    });
                  }

                  n++;
                }
              });
            });
          });
        },
      );

      FirebaseFirestore.instance.collection("info").snapshots().listen(
        (event) {
          event.docChanges.forEach((element) async {
            await FirebaseFirestore.instance
                .collection('info')
                .where('tid', isEqualTo: widget.tourid)
                .get()
                .then((querySnapshot) {
              querySnapshot.docs.forEach((element) {
                geo = element.get("driverlocation");
              });
            });
          });
        },
      );
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(geo.latitude, geo.longitude), zoom: 70),
        ),
      );
    });
  }

  LatLng _initialCameraPosition = LatLng(30.4408569, 30.960889444444444);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          markers: Set.from(mymarker),
          initialCameraPosition:
              CameraPosition(target: _initialCameraPosition, zoom: 70),
          mapType: MapType.normal,
          onMapCreated: _onmapcreated,
          myLocationEnabled: true,
        ),
        Positioned(
          child: FlatButton(
            onPressed: () {
              add();
              print("k");
            },
            color: Colors.black,
            child: Icon(
              Icons.icecream,
              color: Colors.red,
            ),
          ),
          bottom: 50,
          left: 10,
        )
      ],
    ));
  }
}
