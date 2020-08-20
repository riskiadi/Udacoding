import 'package:cek_login/behavior/cliper_header.dart';
import 'package:cek_login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cek_login/widgets/buttonwidget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String username;
  final String password;

  const HomePage({Key key, this.username, this.password}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value){
     setState(() {
       sharedPreferences = value;
     });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          ClipPath(
            clipper: CliperHeader(),
            child: Container(
              color: Color(0xff393e46),
              height: 260,
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('assets/profile.png'),height: 70,),
                        SizedBox(height: 10,),
                        Text(sharedPreferences?.get('sUsername'), style: TextStyle(color: Colors.white, fontSize: 20),),
                        SizedBox(height: 3,),
                        Text(sharedPreferences?.get('sEmail'), style: TextStyle(color: Colors.white),),
                        SizedBox(height: 30,),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              decoration: BoxDecoration(
                color:Color(0xff393e46),
                borderRadius: BorderRadius.circular(9),
              ),
              child: ListTile(
                title: Text("Name", style: TextStyle(color: Colors.white),),
                subtitle: Text(sharedPreferences?.get('sName'), style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              decoration: BoxDecoration(
                color:Color(0xff393e46),
                borderRadius: BorderRadius.circular(9),
              ),
              child: ListTile(
                title: Text("Phone", style: TextStyle(color: Colors.white),),
                subtitle: Text(sharedPreferences?.get('sPhone'), style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Padding(
              padding: EdgeInsets.only(right: 100, left: 100),
              child: ButtonWidget(
                title: "Logout",
                onTapFunction: (){logout();},
              ))
        ],
      ),
    );
  }

  logout(){
    sharedPreferences.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
    toast("Logout Success");
  }

  toast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xffED981C),
        textColor: Colors.black,
        fontSize: 16.0);
  }

}