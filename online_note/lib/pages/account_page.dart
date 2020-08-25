import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  SharedPreferences sharedPreferences;
  String userName;
  String userEmail;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value){
      setState(() {
        sharedPreferences = value;
        userName = value.get('sName');
        userEmail = value.get('sEmail');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff202125),
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0,),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Image(
                image: AssetImage('assets/images/account.png'),
                height: 100,
              ),
              SizedBox(
                height: 17,
              ),
              Text(
                userName??"-",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                userEmail??"-",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 120,
                child: MaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.exit_to_app),
                      Text("Logout")
                    ],
                  ),
                  color: Colors.white,
                  elevation: 0,
                  onPressed: (){
                    logout();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  logout(){
    sharedPreferences.clear();
    Navigator.pushReplacementNamed(context, '/login');
    toast("Logout Success");
  }

  toast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xff6aa0e1),
        textColor: Colors.black,
        fontSize: 16.0);
  }

}