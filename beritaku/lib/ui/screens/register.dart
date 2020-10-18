import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../widgets/buttonwidget.dart';
import '../widgets/textfieldwidget.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var _formKeyRegister = GlobalKey<FormState>();

  TextEditingController cName = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Form(
            key: _formKeyRegister,
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
                      Text('Register', style: TextStyle(color: Colors.red, fontSize: 40, fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: 50,
                      ),
                      TextFieldWidget(
                        textFormColor: Colors.red,
                        textController: cName,
                        hintText: "Full Name",
                        obscureText: false,
                        prefixIconData: Icons.account_circle,
                        isAutoValidator: true,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFieldWidget(
                        textFormColor: Colors.red,
                        textController: cEmail,
                        hintText: "Email",
                        obscureText: false,
                        prefixIconData: Icons.email,
                        inputType: TextInputType.emailAddress,
                        isAutoValidator: true,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFieldWidget(
                            textFormColor: Colors.red,
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
          )),
    );
  }

  submitDataRegister() async {
    setState(() {
      _loading = true;
    });
    var url = 'https://flutterest.000webhostapp.com/nagari/Api/register';
    var post = {
      "full_name": cName.text,
      "password": cPassword.text,
      "email": cEmail.text,
    };
    final responseData = await http.post(url, body: post);
    final data = jsonDecode(responseData.body);
    String message = data['message'];
    toast(message);
    setState(() {
      _loading = false;
    });
    if(data['status'] == 200){
      Get.back();
    }
  }

  toast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}