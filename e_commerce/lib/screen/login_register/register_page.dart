import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/repository/network_repo.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<ScaffoldState> keyState = GlobalKey<ScaffoldState>();
  User userData = User();
  bool hidePass = true;

  void registerUser() {
    progressDialog(context);
    networkRepo.registerUser(userData).then((value) {
      Navigator.pop(context);
      if (value != null) {
        Navigator.pop(context);
      } else {
        SnackBar snackBar = SnackBar(content: Text("Gagal Register"));
        keyState.currentState.showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: keyState,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(16),
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'images/login.png',
                              width: 80,
                              height: 80,
                            )),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "REGISTER",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600),
                            )),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Fullname"),
                          initialValue: userData?.userNama ?? "",
                          onChanged: (value) {
                            setState(() => userData?.userNama = value);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Email"),
                          initialValue: userData?.userEmail ?? "",
                          onChanged: (value) {
                            setState(() => userData?.userEmail = value);
                          },
                        ),
                        TextFormField(
                          obscureText: hidePass,
                          decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(hidePass
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() => hidePass = !hidePass);
                              },
                            ),
                          ),
                          initialValue: userData?.userPassword ?? "",
                          onChanged: (value) {
                            setState(() => userData?.userPassword = value);
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: "Number Phone"),
                          initialValue: userData?.userHp ?? "",
                          onChanged: (value) {
                            setState(() => userData?.userHp = value);
                          },
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                height: 45,
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    textColor: baseColor,
                                    color: Colors.white,
                                    child: Text("Kembali"),
                                    onPressed: () => Navigator.pop(context)),
                              ),
                              SizedBox(width: 16),
                              Container(
                                height: 45,
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    textColor: Colors.white,
                                    color: baseColor,
                                    child: Text("Register"),
                                    onPressed: () {
                                      registerUser();
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
