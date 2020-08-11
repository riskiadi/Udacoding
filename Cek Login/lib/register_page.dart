import 'package:flutter/material.dart';
import 'package:cek_login/login_page.dart';
import 'package:cek_login/widgets/buttonwidget.dart';
import 'package:cek_login/widgets/textfieldwidget.dart';

import 'behavior/disable_overscroll.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFieldWidget(
                          hintText: "Email",
                          obscureText: false,
                          prefixIconData: Icons.email,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFieldWidget(
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
                              hintText: "Password",
                              obscureText: true,
                              prefixIconData: Icons.lock,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ButtonWidget(
                          title: "Register",
                          onTapFunction: () {},
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ButtonWidget(
                          title: "Back to Login",
                          hasBorder: true,
                          onTapFunction: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}