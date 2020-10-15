import 'package:beritaku/ui/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    GetStorage _getStorage = GetStorage();

    return Scaffold(
      appBar: AppBar(title: Text('Profile'),),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 50),
            SvgPicture.asset('assets/images/avatar.svg', width: 170,),
            SizedBox(height: 20),
            Text(_getStorage.read('sName'), style: TextStyle(fontSize: 20),),
            Text(_getStorage.read('sEmail'), style: TextStyle(fontSize: 20),),
            SizedBox(height: 50),
            FlatButton(
              color: Colors.red,
              child: Text('Logout', style: TextStyle(color: Colors.white),),
              onPressed: (){
                _getStorage.erase();
                Get.offAll(LoginPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
