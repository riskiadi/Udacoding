import 'dart:convert';

import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/repository/network_repo.dart';
import 'package:e_commerce/screen/dashboard_home.dart';
import 'package:e_commerce/screen/login_register/register_page.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User userData = User();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool hidePass = true;

  void loginUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    progressDialog(context);
    networkRepo.loginUser(userData).then((value) {
      Navigator.pop(context);
      if (value != null) {
        setState(() {
          User userVal = value;
          String user = jsonEncode(userVal.toJson());
          prefs.setBool("statusLogin", true);
          prefs.setString("userData", user);
          prefs.commit();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardHome()));
        });
      } else {
        SnackBar snackBar = SnackBar(content: Text("Gagal Login"));
        scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(16),
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'images/login.png',
                              width: 80,
                              height: 80,
                            )),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600),
                            )),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(hintText: "Email"),
                          initialValue: userData?.userEmail ?? "",
                          onChanged: (value) {
                            setState(() => userData?.userEmail = value);
                          },
                        ),
                        TextFormField(
                          obscureText: hidePass,
                          decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(hidePass
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() => hidePass = !hidePass);
                              },
                            ),
                          ),
                          initialValue: userData?.userPassword ?? "",
                          onChanged: (value) {
                            setState(() => userData?.userPassword = value);
                          },
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                              textColor: baseColor,
                              child: Text("Lupa Password ?"),
                              onPressed: () {}),
                        ),
                        Container(
                          width: double.infinity,
                          height: 45,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              textColor: Colors.white,
                              color: baseColor,
                              child: Text("Login"),
                              onPressed: () {
                                loginUser();
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("New User?",
                                    style: TextStyle(color: Colors.black87)),
                                Text("Signup",
                                    style: TextStyle(color: baseColor))
                              ],
                            ),
                            onPressed: () {
                              goTo(context, RegisterPage());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
