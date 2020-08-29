import 'package:flutter/material.dart';
import 'package:simple_ecomerce/home.dart';
import 'package:simple_ecomerce/onboarding.dart';
import 'package:simple_ecomerce/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto_Condensed'
      ),
      home: OnBoardingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}