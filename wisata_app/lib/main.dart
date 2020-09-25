import 'package:flutter/material.dart';
import 'package:wisata_app/ui/home.dart';
import 'package:wisata_app/ui/login.dart';
import 'package:wisata_app/ui/splash.dart';
import 'package:wisata_app/widgets/camera_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}