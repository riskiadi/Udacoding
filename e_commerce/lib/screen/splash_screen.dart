import 'dart:async';
import 'package:e_commerce/screen/login_register/login_page.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:e_commerce/utils/session_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  var _visible = true;
  AnimationController animationController;
  Animation<double> animation;

  void onLoading() async {
    Future.delayed((Duration(seconds: 5)), () {
      sessionManager.getSesi(context);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onLoading();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 5));
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.easeInOut);
    animation.addListener(() => this.setState(() {}));
    animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this.animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: baseColor,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'images/bakulan.png',
                  width: animation.value * 250,
                  height: animation.value * 250,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
