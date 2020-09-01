import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'login.dart';

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
      body: Container(
        child: Center(child: Text('Loading...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),)),
      ),
    );
  }

  isLogin()async{
    var sharedPref = await SharedPreferences.getInstance();
    if(sharedPref.get('value') == 1){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
    }
  }

}
