import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5),() async{
      isLogin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 190,
          height: 190,
          child: FlareActor(
            'assets/liquid.flr',
            animation: 'Untitled',
          ),
        ),
      ),
    );
  }

  isLogin() async {
    var sharedPreference = await SharedPreferences.getInstance();
    setState(() {
      int status = sharedPreference.get("value");
      if(status == 1){
        Navigator.pushReplacementNamed(context, '/home');
      }else{
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

}
