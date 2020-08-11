import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cek_login/widgets/buttonwidget.dart';

class HomePage extends StatefulWidget {
  final String username;
  final String password;

  const HomePage({Key key, this.username, this.password}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username;
  String password;

  @override
  void initState() {
    username = widget.username;
    password = widget.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(image: AssetImage('assets/profile.png'),height: 60,),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle,
                  color: const Color(0xffED981C),
                  size: 20.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  "Username: $username",
                  style: TextStyle(color: const Color(0xffED981C)),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  color: const Color(0xffED981C),
                  size: 20.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  "Password: $password",
                  style: TextStyle(color: const Color(0xffED981C)),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
                padding: EdgeInsets.only(right: 100, left: 100),
                child: ButtonWidget(
                  title: "Logout",
                  onTapFunction: ()=> Navigator.pop(context),
                ))
          ],
        ),
      ),
    );
  }
}
