import 'package:flutter/material.dart';
import 'package:profil_sekolah/pages/home.dart';
import 'package:profil_sekolah/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((value){
      _getPrefData().then((value){
        if(value.getString('name')!=null && value.getString('email')!=null && value.getString('photo')!=null){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Please Wait...'),
              SizedBox(height: 30,),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Future<SharedPreferences> _getPrefData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }
  

}
