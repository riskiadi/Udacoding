import 'dart:convert';

import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/screen/dashboard_home.dart';
import 'package:e_commerce/screen/login_register/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {

  Future clearSesi(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (conttext) => LoginPage()),
        (route) => false);
  }

  Future<User> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map map = jsonDecode(pref.get("userData"));
    User userData = User.fromJson(map);
    return userData;
  }

  Future getSesi(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool status = pref.getBool("statusLogin");
    Map map;
    if (pref.get("userData") != null) {
      map = jsonDecode(pref.get("userData"));
      User userData = User.fromJson(map);
      print("UserData ${userData.userId}");
    }
    if (status == true && map != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => DashboardHome()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginPage()));
    }
  }
}

final sessionManager = SessionManager();
