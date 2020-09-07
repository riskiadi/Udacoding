import 'dart:convert';
import 'package:data_mahasiswa/db_helper_login.dart';
import 'package:data_mahasiswa/models/admin.dart';
import 'package:data_mahasiswa/utils/color.dart';
import 'package:data_mahasiswa/widgets/button_widget.dart';
import 'package:data_mahasiswa/widgets/text_field_login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var _formKeyRegister = GlobalKey<FormState>();

  TextEditingController cName = TextEditingController();
  TextEditingController cUsername = TextEditingController();
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
                        textController: cName,
                        hintText: "Name",
                        obscureText: false,
                        prefixIconData: Icons.accessibility,
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
          )),
    );
  }

  submitDataRegister(){
    DatabaseHelperLogin db = new DatabaseHelperLogin();
    db.createUser(Admin(cName.text, cUsername.text, cPassword.text)).then((value){
      toast('Successfuly register');
      Navigator.pop(context);
    });
  }

  toast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: CustomColor.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}