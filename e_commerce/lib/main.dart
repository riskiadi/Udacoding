import 'package:e_commerce/repository/network_repo.dart';
import 'package:e_commerce/screen/dashboard_home.dart';
import 'package:e_commerce/screen/splash_screen.dart';
import 'package:flutter/material.dart';

final String SIGN_IN = "signin";
final String SIGN_UP = "signup";
final String SPLASH_SCREEN = "splashscreen";
final String HOME_PAGE = "homepage";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.green,
          primaryTextTheme: Typography.whiteMountainView,
          primaryIconTheme: IconThemeData(color: Colors.white)),
      routes: {
        HOME_PAGE: (context) => DashboardHome(),
        SPLASH_SCREEN: (context) => SplashScreen(),
      },
      initialRoute: SPLASH_SCREEN,
    );
  }
}
