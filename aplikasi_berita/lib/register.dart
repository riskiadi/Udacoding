import 'dart:convert';

import 'package:aplikasi_berita/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController cName = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPassowrd = TextEditingController();
  bool _obscureText = true;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFF0F0F0),
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
                  Text("Register", style: TextStyle(fontSize: 28, letterSpacing: 4),),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: cName,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide.none
                      ),
                      prefixIcon: Icon(Icons.email, size: 20,),
                      labelText: 'Full Name',
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 10),
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
                        children: isLoading ? [SizedBox(height: 14,width: 14,child: CircularProgressIndicator())] : [Icon(Icons.edit), SizedBox(width: 14), Text('Register')],
                      ),
                      color: Colors.amber,
                      onPressed: () {
                        _registerFunction(cName.text, cEmail.text, cPassowrd.text);
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text('Back to login'),
                      color: Colors.lightGreen,
                      onPressed: () {
                        Navigator.pop(context);
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

  _registerFunction(String name, String email, String password){
    setState(() {isLoading = true;});
    Api().registerUser(name, email, password).then((Response value){
      var response = jsonDecode(value.body);
      if(response['status'] == 200){
        _alertDialog('Daftar berhasil');
      }else{
        _alertDialog('Daftar gagal');
      }
      setState(() {isLoading = false;});
    });
  }

  _alertDialog(String message){
    var alertDialog = AlertDialog(
      title: Text('Pendaftaran'),
      content: Text(message),
      actions: [
        FlatButton(child: Text('Ok'), onPressed: () {Navigator.pop(context);}),
      ],
    );
    return showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }

}
