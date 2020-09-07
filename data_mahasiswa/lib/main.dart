import 'package:data_mahasiswa/pages/login.dart';
import 'package:data_mahasiswa/pages/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Mahasiswa',
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.black45,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}