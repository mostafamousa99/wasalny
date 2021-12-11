import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_location_gmap/clientresult.dart';
import 'package:flutter_live_location_gmap/clientview.dart';
import 'package:flutter_live_location_gmap/d_r.dart';
import 'package:flutter_live_location_gmap/driverview.dart';
import 'package:flutter_live_location_gmap/loginclient.dart';
import 'package:flutter_live_location_gmap/logindriver.dart';
import 'package:flutter_live_location_gmap/signup_client.dart';
import 'package:flutter_live_location_gmap/signup_driver.dart';
import 'package:flutter_live_location_gmap/test.dart';
import 'package:provider/provider.dart';

import 'location_map.dart';
import 'location_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: dr(),
    );
  }
}
