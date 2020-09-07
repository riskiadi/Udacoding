import 'dart:convert';
import 'dart:io';
import 'package:data_mahasiswa/db_helper_login.dart';
import 'package:data_mahasiswa/models/admin.dart';
import 'package:data_mahasiswa/pages/home.dart';
import 'package:data_mahasiswa/pages/register.dart';
import 'package:data_mahasiswa/utils/color.dart';
import 'package:data_mahasiswa/widgets/button_widget.dart';
import 'package:data_mahasiswa/widgets/text_field_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _loading = false;

  final cUsername = TextEditingController();
  final cPassword = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          body: Container(
            alignment: Alignment.center,
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
                        Text('Login', style: TextStyle(color: Colors.red, fontSize: 40, fontWeight: FontWeight.bold),),
                        SizedBox(
                          height: 50,
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
                          isLoading: _loading,
                          title: "Login",
                          onTapFunction: () {
                            if(_loginFormKey.currentState.validate()){
                              _loading = true;
                              submitDataLogin();
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPage(),));
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  submitDataLogin() {
    DatabaseHelperLogin db = new DatabaseHelperLogin();
    db.getUser(username: cUsername.text, password: cPassword.text).then((value){
      if(value!=null){
        saveData(value);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
      }else{
        toast('Username or password is wrong');
      }
    });
  }

  saveData(Admin data) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('userData', jsonEncode({
      "id":data.id,
      "name":data.name,
      "username":data.username
    }));
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
