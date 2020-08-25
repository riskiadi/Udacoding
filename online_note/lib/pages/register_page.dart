import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_note/behavior/disable_overscroll.dart';
import 'package:online_note/widgets/buttonwidget.dart';
import 'package:online_note/widgets/textfieldwidget.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var _formKeyRegister = GlobalKey<FormState>();

  TextEditingController cName = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPhone = TextEditingController();
  TextEditingController cUsername = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff202125),
          body: Form(
            key: _formKeyRegister,
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
                          textController: cName,
                          hintText: "Name",
                          obscureText: false,
                          prefixIconData: Icons.account_circle,
                          isAutoValidator: true,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFieldWidget(
                          textController: cEmail,
                          hintText: "Email",
                          obscureText: false,
                          prefixIconData: Icons.email,
                          inputType: TextInputType.emailAddress,
                          isAutoValidator: true,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFieldWidget(
                          textController: cPhone,
                          hintText: "Phone",
                          obscureText: false,
                          prefixIconData: Icons.phone,
                          inputType: TextInputType.number,
                          isAutoValidator: true,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFieldWidget(
                          textController: cUsername,
                          hintText: "Username",
                          obscureText: false,
                          prefixIconData: Icons.account_circle,
                          isAutoValidator: true,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextFieldWidget(
                              textController: cPassword,
                              hintText: "Password",
                              obscureText: true,
                              prefixIconData: Icons.lock,
                              isAutoValidator: true,
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
                          isLoading: _loading,
                          title: "Register",
                          onTapFunction: () {
                            if(_formKeyRegister.currentState.validate()){
                              submitDataRegister();
                            }
                          },
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

  submitDataRegister() async {
    setState(() {
      _loading = true;
    });
    final responseData = await http.post('https://alkalynxt.000webhostapp.com/udacoding_note/register/',
        body: {
          "name": cName.text,
          "username": cUsername.text,
          "password": cPassword.text,
          "email": cEmail.text,
          "phone": cPhone.text,
        });
    final data = jsonDecode(responseData.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      toast(message);
    } else if (value == 2) {
      toast(message);
    } else {
      toast(message);
    }
    setState(() {
      _loading = false;
    });
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
