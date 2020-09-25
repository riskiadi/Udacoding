import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_app/repository.dart';
import 'package:wisata_app/ui/home.dart';
import 'package:wisata_app/ui/login.dart';
import 'package:wisata_app/ui/onboarding.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {

    _isFirstOpen().then((isOpened){

      Future.delayed(Duration(seconds: 8)).then((value){
        if(isOpened){

          UserRepository().isLogin().then((isLogin){
            if(isLogin){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
            }else{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
            }
          });

        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoardingPage(),));
        }
      });

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Teravelapp",
              style: TextStyle(letterSpacing: 3, fontSize: 30,),
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset('assets/loading.json'),
            ),
            Text("Please wait",),
          ],
        ),
      ),
    );
  }

  Future<bool> _isFirstOpen() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isOpen')==null ? false : true;
  }

}
