import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_app/ui/login.dart';

class ProfilePage extends StatelessWidget {
  final String photo;
  final String name;
  final String email;

  const ProfilePage({Key key, this.photo, this.name, this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0.1),
          leading: IconButton(
              icon: Icon(CupertinoIcons.back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Hero(
                tag: 'profile_image',
                child: Image.network(
                  photo ??
                      'https://www.freeiconspng.com/uploads/loading-icon-1.png',
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: 300,
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name:"),
                  Text(
                    name,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Email:"),
                  Text(
                    email,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: RaisedButton(
                color: Colors.red,
                child: Text(
                  'Sign out',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _handleSignOut().then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                        (route) => false);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignOut() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _googleSignIn.disconnect();
    sharedPreferences.clear();
  }
}
