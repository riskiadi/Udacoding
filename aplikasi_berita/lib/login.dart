import 'dart:convert';

import 'package:aplikasi_berita/api.dart';
import 'package:aplikasi_berita/home.dart';
import 'package:aplikasi_berita/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController cEmail = TextEditingController();
  TextEditingController cPassowrd = TextEditingController();
  bool _obscureText = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _isLogin().then((bool isLogin){
      if(isLogin) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login", style: TextStyle(fontSize: 28, letterSpacing: 4),),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: cEmail,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide.none
                      ),
                      prefixIcon: Icon(Icons.email, size: 20,),
                      labelText: 'Email',
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: cPassowrd,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key, size: 20,),
                      suffixIcon: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        child: Icon(Icons.remove_red_eye, size: 20,),
                        onTap: (){
                          setState(() {
                            _obscureText = _obscureText ? false : true;
                          });
                        },
                      ),
                      labelText: 'Password',
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: isLoading ? [SizedBox(height: 14,width: 14,child: CircularProgressIndicator())] : [Icon(Icons.exit_to_app), SizedBox(width: 14), Text('Login')],
                      ),
                      color: Colors.amber,
                      onPressed: () {
                        _loginFunction(cEmail.text, cPassowrd.text);
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.create), SizedBox(width: 14), Text('Register')],
                      ),
                      color: Colors.lightGreen,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loginFunction(String email, String password){
    setState(() {isLoading = true;});
    Api().loginUser(email, password).then((Response value){
      var response = jsonDecode(value.body);
      if(response['status'] == 200){
        _saveData(
          id: response['data']['id'],
          name: response['data']['fullname'],
          email: response['data']['email'],
        ).then((value){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      }else{
        _alertDialog();
      }
      setState(() {isLoading = false;});
    });
  }

  Future<void> _saveData({int id, String name, String email}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('user_id', id);
    sharedPreferences.setString('name', name);
    sharedPreferences.setString('email', email);
  }

  _alertDialog(){
    var alertDialog = AlertDialog(
      title: Text('Login Gagal'),
      content: Text('Email atau kata sandi mungkin salah'),
      actions: [
        FlatButton(child: Text('Retry'), onPressed: () {Navigator.pop(context);}),
      ],
    );
    return showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }

  Future<bool> _isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('email').isNotEmpty ;
  }

}
