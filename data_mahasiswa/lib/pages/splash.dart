import 'package:data_mahasiswa/pages/home.dart';
import 'package:data_mahasiswa/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((value){
      _isLogin().then((value){
        value ? Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(),)) : Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage(),));
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Lottie.asset('assets/loading.json'),
        ),
      ),
    );
  }

  Future<bool> _isLogin() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    if(sp.getString('userData')==null){
      return false;
    }else{
      return true;
    }
  }
  
  
}
