import 'package:absent_udacoding/ui_page/user/DetailUser.dart';
import 'package:absent_udacoding/utils/SessionManager.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String globRole = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var sessionManager = SessionManager();
    sessionManager.getPreference().then((value) {
      setState(() {
        globRole = sessionManager.globRole;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: DetailUser(globRole: globRole),
          )
        ],
      ),
    );
  }
}
