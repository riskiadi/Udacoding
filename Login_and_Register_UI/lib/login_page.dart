import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/register_page.dart';
import 'package:flutter_app/widgets/buttonwidget.dart';
import 'package:flutter_app/widgets/textfieldwidget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(16, 16, 15, 100.0),
          body: Container(
            padding: const EdgeInsets.all(35.0),
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
                  hintText: "Username",
                  obscureText: false,
                  prefixIconData: Icons.people,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFieldWidget(
                      hintText: "Password",
                      obscureText: true,
                      prefixIconData: Icons.lock,
                    ),
                    SizedBox(height: 15.0,),
                    Text("Forgot Password?",
                      style: TextStyle(color: Colors.white),),
                  ],
                ),
                SizedBox(height: 30.0,),
                ButtonWidget(
                  title: "Login",
                  onTapFunction: (){},
                ),
                SizedBox(height: 15.0,),
                ButtonWidget(
                  title: "Register",
                  hasBorder: true,
                  onTapFunction: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegisterPage())
                    );
                  },
                )
              ],
            ),
          )),
    );
  }
}
