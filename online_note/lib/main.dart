import 'package:flutter/material.dart';
import 'package:online_note/pages/account_page.dart';
import 'package:online_note/pages/addnote_page.dart';
import 'package:online_note/pages/alternote_page.dart';
import 'package:online_note/pages/home_page.dart';
import 'package:online_note/pages/login_page.dart';
import 'package:online_note/pages/register_page.dart';
import 'package:online_note/pages/splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => SplashPage(),
        '/login' : (context) => LoginPage(),
        '/register' : (context) => RegisterPage(),
        '/home' : (context) => HomePage(),
        '/addnote' : (context) => AddNotePage(),
        '/alternote' : (context) => AlterNotePage(),
        '/account' : (context) => AccountPage(),
      },
    );
  }
}