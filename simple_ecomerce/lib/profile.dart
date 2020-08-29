import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_ecomerce/const/custom_color.dart';
import 'package:simple_ecomerce/login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SharedPreferences sharedPreferences;
  String username;
  String email;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
      username = value.get('sUsername');
      email = value.get('sEmail');
      //    final value = data["value"];
//    final message = data["message"];
//    final dataID = data["user_id"];
//    final dataName = data["name"];
//    final dataUsername = data["username"];
//    final dataEmail = data["email"];
//    final dataPhone = data["phone"];
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'), elevation: 0, backgroundColor: CustomColor.red,),
      body: Column(
        children: [
          SizedBox(height: 25),
          Center(
            child: ClipOval(
              child: Container(
                color: Colors.red,
                width: 130,
                height: 130,
                child: Image.asset(
                  'assets/profileimage.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            username ?? "",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            email ?? "",
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(
            height: 30,
          ),
          FlatButton(
              onPressed: () {
                sharedPreferences.clear();
                setState(() {});
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage(),), (route) => false);
              },
              color: CustomColor.red,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Feather.log_out, color: Colors.white, size: 18,),
                  SizedBox(width: 10,),
                  Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
          )
        ],
      ),
    );
  }
}
