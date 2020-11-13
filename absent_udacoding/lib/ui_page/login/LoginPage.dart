import 'package:absent_udacoding/DashboardPage.dart';
import 'package:absent_udacoding/constant/ConstantFile.dart';
import 'package:absent_udacoding/model/ModelRole.dart';
import 'package:absent_udacoding/network/NetworkProvider.dart';
import 'package:absent_udacoding/utils/SessionManager.dart';
import 'package:flutter/material.dart';

import 'ResgisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>(); // Key for validate form
  final scaffoldKey = GlobalKey<ScaffoldState>(); // Key for snackbar

  BaseEndPoint network = NetworkProvider();
  TextEditingController etUsername = TextEditingController();
  TextEditingController etPassword = TextEditingController();

  String _username;
  String _password;

  var status = false;
  var globIduser, globName, globEmail, globPhoto, globPhone, globUsername;
  var globStatus;
  var _obSecure = true;
  void onHidePassword() {
    if (_obSecure == true) {
      setState(() {
        _obSecure = false;
      });
    } else {
      setState(() {
        _obSecure = true;
      });
    }
  }

  void onValidate() async {
    final form = formKey.currentState;
    progressDialog(context);
    if (form.validate()) {
      form.save();
      if (etUsername.text.isEmpty || etPassword.text.isEmpty) {
        showSnackbar("Username atau Password tidak boleh kosong");
      } else {
        List listData = await network.loginUser(
            etUsername.text.toString(), etPassword.text.toString(), context);
        Navigator.pop(context);
        if (listData != null) {
          User data = listData[0];
          print("myData : ${data.idUser} ${data.fullnameUser} ${data.emailUser} ");
          setState(() {
            status = true;
            SessionManager().savePreference(
                status,
                data.idUser,
                data.fullnameUser,
                data.emailUser,
                data.phoneUser,
                data.photoUser,
                data.usernameUser,
                data.nameRole);
          });
          getPreference();
        } else {
          showSnackbar("Username atau Password salah");
        }
      }
    }
  }

  void getPreference() async {
    SessionManager sm = SessionManager();
    await sm.getPreference();
    setState(() {
      globStatus = sm.globStatus;
      globIduser = sm.globIduser;
      globName = sm.globName;
      globEmail = sm.globEmail;
      globPhone = sm.globPhone;
      globPhoto = sm.globPhoto;
      globUsername = sm.globUsername;
      if (globStatus == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashboardPage()));
      } else {
        print("Status tidak ada");
      }
    });
    print("Global Status = $globStatus");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreference();
  }


  void showSnackbar(String title) {
    final snackbar = SnackBar(
      content: Text("$title"),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/bg.png'),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset('images/absen.png'),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    controller: etUsername,
                                    decoration: InputDecoration(
                                        hintText: 'Username',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                  ),
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    controller: etPassword,
                                    obscureText: _obSecure,
                                    validator: (val) => val.length < 6
                                        ? 'Password to short'
                                        : null,
                                    onSaved: (val) => _password = val,
                                    decoration: InputDecoration(
                                        hintText: 'Password',
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obSecure
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            size: 25,
                                          ),
                                          onPressed: () {
                                            onHidePassword();
                                          },
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          borderSide: BorderSide(
                                            color: Colors.green,
                                          ),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 350,
                                    child: RaisedButton(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                      onPressed: () {
                                        onValidate();
                                        // push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
                                      },
                                    ),
                                  ),
                                  
                                  FlatButton(
                                    textColor:Colors.white,
                                    child: Text("I don\'t have an account"),
                                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage())),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      'Version 1.0',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
