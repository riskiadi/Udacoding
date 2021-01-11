import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:e_commerce/utils/session_manager.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User userData;
  void getUser() async {
    sessionManager.getUser().then((value) {
      setState(() {
        userData = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text("Account", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image: NetworkImage(dummySeller),
                                fit: BoxFit.fill)),
                      ),
                      SizedBox(width: 16),
                      Text(userData?.userNama ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/points.png',
                                width: 25, height: 25, fit: BoxFit.fill),
                            Text("Manggaleh Points",
                                style: TextStyle(fontSize: 12)),
                            Text("2.000",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/voucher.png',
                                width: 25, height: 25, fit: BoxFit.fill),
                            Text("Voucher Saya",
                                style: TextStyle(fontSize: 12)),
                            Text("4",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/member.png',
                                width: 25, height: 25, fit: BoxFit.fill),
                            Text("Toko Member", style: TextStyle(fontSize: 12)),
                            Text("2",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(thickness: 15, color: Colors.black.withOpacity(0.1)),
            Divider(thickness: 2, height: 0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text("Kebijakan Privasi"),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                ),
                Divider(thickness: 2, height: 0),
                ListTile(
                  title: Text("Pengaturan"),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                ),
                Divider(thickness: 2, height: 0),
                ListTile(
                  title: Text("Syarat dan Ketentuan"),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                ),
                Divider(thickness: 2, height: 0),
                ListTile(
                  title: Text("Bantuan"),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                ),
                Divider(thickness: 2, height: 0),
                InkWell(
                  onTap: () {
                    sessionManager.clearSesi(context);
                  },
                  child: ListTile(
                    title: Text("Keluar"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                ),
                Divider(thickness: 2, height: 0),
              ],
            ),
            ListTile(
              title: Text("Versi 1.0"),
            ),
          ],
        ),
      ),
    );
  }
}
