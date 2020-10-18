import 'package:beritaku/ui/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import 'home.dart';
import 'onboarding.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((value){
      Get.off(checkWidget());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/images/loading.json',
              fit: BoxFit.cover,
              width: 100,
            ),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }

  Widget checkWidget(){
    final getStorage = GetStorage();
    if(getStorage.read('onBoarding')??false){
      if(getStorage.read('isLogin')??false){
        return HomePage();
      }else{
        return LoginPage();
      }
    }else{
      return OnBoardingPage();
    }
  }

}
