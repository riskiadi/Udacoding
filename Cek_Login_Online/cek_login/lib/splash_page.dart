import 'dart:async';

import 'package:cek_login/login_page.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: Lottie.asset(
            'assets/crown.json',
            onLoaded: (composition) {
              startTimer(composition.duration);
            },
          ),
        ),
      ),
    );
  }

  Future<Timer> startTimer(Duration duration) async{
    return Timer(duration, (){
      isLoggedIn();
    });
  }

  isLoggedIn() async {
    var sharedPreference = await SharedPreferences.getInstance();
    setState(() {
      int status = sharedPreference.get("value");
      if(status == 1){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      }
    });
  }

}
