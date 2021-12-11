import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Clientmap extends StatefulWidget {
  final String tourid;

  const Clientmap({Key key, this.tourid}) : super(key: key);
  @override
  _ClientmapState createState() => _ClientmapState();
}

class _ClientmapState extends State<Clientmap> {
  LatLng _initialCameraPosition = LatLng(30.4408569, 30.960889444444444);
  GeoPoint geo;

  GoogleMapController _controller;
  List<Marker> mymarker = [];
  BitmapDescriptor customIcon;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMarker();
  }

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
              onPressed: () {},
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
      ),
    );
  }

  void _onmapcreated(GoogleMapController _crtl) async {
    _controller = _crtl;

    await FirebaseFirestore.instance.collection("info").snapshots().listen(
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

          _controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(geo.latitude, geo.longitude), zoom: 70),
            ),
          );

          setState(() {
            mymarker.add(
              Marker(
                markerId: MarkerId("1"),
                position: LatLng(geo.latitude, geo.longitude),
                icon: customIcon,
              ),
            );
          });
          updatemk(geo.latitude, geo.longitude);
        });
      },
    );
  }

  void setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        "assets/destination_map_marker.png");
  }

  void updatemk(double l1, double l2) {
    setState(() {
      mymarker[0] = mymarker[0].copyWith(
        positionParam: LatLng(l1, l2),
      );
      print(l1);
    });
    /*setState(() {
      mymarker[0] = Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      ));
    });*/
  }
}
