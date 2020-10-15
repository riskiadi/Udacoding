import 'dart:io';
import 'package:beritaku/ui/screens/home.dart';
import 'package:beritaku/ui/screens/register.dart';
import 'package:beritaku/ui/widgets/buttonwidget.dart';
import 'package:beritaku/ui/widgets/textfieldwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _loading = false;

  final cEmail = TextEditingController();
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
                          textController: cEmail,
                          hintText: "Email",
                          obscureText: false,
                          prefixIconData: Icons.account_circle,
                          isAutoValidator: true,
                          textFormColor: Colors.red,
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
                              textFormColor: Colors.red,
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

  submitDataLogin() async {
    var data;
    setState(() {
      _loading = true;
    });
    try{
      var url="https://flutterest.000webhostapp.com/nagari/Api/login";
      var post = {
        "email": cEmail.text,
        "password": cPassword.text,
      };
      final responseData = await http.post(url, body: post);
      data = jsonDecode(responseData.body);
      setState(() {
        _loading = false;
      });
    }on SocketException{
      toast("No Internet Connection");
      setState(() {
        _loading = false;
      });
    }
    final status = data["status"];
    final message = data["message"];
    setState(() {
      if(status==200){
        final dataId = data["data"]['id'];
        final dataName = data["data"]['fullname'];
        final dataEmail = data["data"]['email'];
        saveData(status: status, id: dataId, name: dataName, email: dataEmail);
      }
      toast(message);
    });
  }

  saveData({int status, int id, String name, String email}) async {
    GetStorage getStorage = GetStorage();
    getStorage.write("isLogin", true);
    getStorage.write("sId", id);
    getStorage.write("sName", name);
    getStorage.write("sEmail", email);
    Get.off(HomePage());
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
