import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cek_login/home_page.dart';
import 'package:cek_login/register_page.dart';
import 'package:cek_login/widgets/buttonwidget.dart';
import 'package:cek_login/widgets/textfieldwidget.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'behavior/disable_overscroll.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _loginFormKey = GlobalKey<FormState>();

  final String username = "admin";
  final String password = "admin";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Color.fromRGBO(16, 16, 15, 100.0),
          body: Container(
            alignment: Alignment.center,
            child: ScrollConfiguration(
              behavior: DisableOverscroll(),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsets.all(35.0),
                    child: Form(
                      key: _loginFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/logo.png'),
                            height: 35,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextFieldWidget(
                            textController: usernameController,
                            hintText: "Username",
                            obscureText: false,
                            prefixIconData: Icons.account_circle,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFieldWidget(
                                textController: passwordController,
                                hintText: "Password",
                                obscureText: true,
                                prefixIconData: Icons.lock,
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          ButtonWidget(
                            title: "Login",
                            onTapFunction: () {
                              if (usernameController.text == username && passwordController.text == password) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(username: this.username, password: this.password,),));
                              }else{
                                Fluttertoast.showToast(
                                    msg: "Incorrect username or password",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: const Color(0xffED981C),
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                              }
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          ButtonWidget(
                            title: "Register",
                            hasBorder: true,
                            onTapFunction: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
