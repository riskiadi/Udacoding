import 'package:aplikasi_berita/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {

  final String name;
  final String email;

  const AccountPage({Key key, this.name, this.email}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Akun"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Icon(Icons.account_circle, size: 80,),
            SizedBox(height: 10),
            Text('Full Name', style: TextStyle(fontSize: 20,),),
            Text(widget.name, style: TextStyle(fontSize: 16),),
            SizedBox(height: 10),
            Text('Email', style: TextStyle(fontSize: 20),),
            Text(widget.email, style: TextStyle(fontSize: 16),),
            SizedBox(height: 20),
            Center(
              child: RaisedButton(
                color: Colors.red,
                child: Text('Logout', style: TextStyle(color: Colors.white),),
                onPressed: (){
                  SharedPreferences.getInstance().then((value){
                    value.clear();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage(),), (route) => false);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
