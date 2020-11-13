import 'package:absent_udacoding/constant/ConstantFile.dart';
import 'package:absent_udacoding/model/ModelAbsent.dart';
import 'package:absent_udacoding/network/NetworkProvider.dart';
import 'package:absent_udacoding/ui_page/history/History.dart';
import 'package:absent_udacoding/ui_page/login/LoginPage.dart';
import 'package:absent_udacoding/ui_page/profile/UpdateProfile.dart';
import 'package:absent_udacoding/ui_page/user/ListUser.dart';
import 'package:absent_udacoding/utils/SessionManager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailUser extends StatefulWidget {
  String globRole;
  DetailUser({this.globRole});
  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  BaseEndPoint network = NetworkProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: network.getAbsent(""),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? Detail(
                list: snapshot.data,
                globRole: widget.globRole,
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class Detail extends StatefulWidget {
  final list;
  String globRole;
  Detail({this.list, this.globRole});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final list;
  _DetailState({this.list});
  String myId, myEmail, myName, myPhone, myPhoto, myUsername, myRole;
  SessionManager sessionManager = SessionManager();
  BaseEndPoint network = NetworkProvider();

  void signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    sharedPreferences.commit();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionManager.getPreference().then((value) {
      setState(() {
        myId = sessionManager.globIduser;
        myEmail = sessionManager.globEmail;
        myName = sessionManager.globName;
        myPhone = sessionManager.globPhone;
        myPhoto = sessionManager.globPhoto;
        myUsername = sessionManager.globUsername;
        myRole = sessionManager.globRole;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.green,
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.mode_edit, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateProfile(
                                        nama: myName,
                                        role: myRole,
                                        email: myEmail,
                                        phone: myPhone,
                                        photo: myPhoto,
                                      )));
                        },
                      ),
                    ),
                    ClipOval(
                      child: myPhoto == null
                          ? Center()
                          : Image.network(
                              ConstantFile().imageUrl + myPhoto,
                              fit: BoxFit.fill,
                              width: 120,
                              height: 120,
                            ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Text(
                        myName ?? "",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Text(
                      myRole ?? "",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.all(8),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(Icons.email),
                        ),
                        title: Text(
                          myEmail ?? "",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Card(
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(Icons.phone),
                          ),
                          title: Text(
                            myPhone ?? "",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.globRole == "Admin",
                      child: GestureDetector(
                        onTap: () {
                          network.getAbsent("").then((value) {
                            List<Absent> listUser = value;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ListUser(list: listUser)));
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Card(
                            child: ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(Icons.playlist_add_check),
                              ),
                              title: Text(
                                'List User ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => History(idUser: myId)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Card(
                          child: ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(Icons.access_time),
                            ),
                            title: Text(
                              'History',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        signOut();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Card(
                          child: ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(Icons.exit_to_app),
                            ),
                            title: Text(
                              'Logout',
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
