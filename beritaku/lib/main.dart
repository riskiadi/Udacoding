import 'package:beritaku/ui/screens/home.dart';
import 'package:beritaku/ui/screens/login.dart';
import 'package:beritaku/ui/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Beritaku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: checkWidget(),
      debugShowCheckedModeBanner: false,
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


