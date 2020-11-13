import 'package:absent_udacoding/constant/ConstantFile.dart';
import 'package:absent_udacoding/ui_page/history/History.dart';
import 'package:absent_udacoding/ui_page/login/LoginPage.dart';
import 'package:absent_udacoding/ui_page/profile/UpdateProfile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileList extends StatefulWidget {
  String nama, role, email, phone, photo, idUser;
  ProfileList(
      {this.nama, this.role, this.email, this.phone, this.photo, this.idUser});
  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              color: Colors.green,
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProfile(
                              nama: widget.nama,
                              role: widget.role,
                              email: widget.email,
                              phone: widget.phone,
                              photo: widget.photo,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 300, top: 10),
                child: IconButton(
                  icon: Icon(
                    Icons.mode_edit,
                  ),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 45),
                      width: 120,
                      height: 120,
                      child: CircleAvatar(
                        radius: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            ConstantFile().imageUrl + widget.photo,
                            fit: BoxFit.fill,
                            width: 120,
                            height: 120,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.nama,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Text(
                      widget.role,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Card(
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(Icons.email),
                          ),
                          title: Text(
                            widget.email,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(Icons.phone),
                          ),
                          title: Text(
                            widget.phone,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    History(idUser: widget.idUser)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(Icons.access_time),
                            ),
                            title: Text(
                              'History ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ]),
    );
  }
}
