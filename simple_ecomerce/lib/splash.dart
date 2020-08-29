import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_ecomerce/const/custom_color.dart';
import 'package:simple_ecomerce/home.dart';
import 'package:simple_ecomerce/login.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((value){
      isLogin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.red,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Toko Merah', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
              SizedBox(height: 250, child: Container(
                width: 180,
                height: 180,
                child: FlareActor(
                  'assets/cart.flr',
                  animation: 'Cube Animation',
                ),
              )),
            ],
          )
      ),
    );
  }

  isLogin() async {
    var sharedPref = await SharedPreferences.getInstance();
    if(sharedPref.get('value')==1){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(),));
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage(),));
    }
    
  }

}
