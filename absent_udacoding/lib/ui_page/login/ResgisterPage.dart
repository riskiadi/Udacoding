import 'package:absent_udacoding/model/ModelUpdate.dart';
import 'package:absent_udacoding/network/NetworkProvider.dart';
import 'package:absent_udacoding/ui_page/login/LoginPage.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>(); // Key for validate form
  final scaffoldKey = GlobalKey<ScaffoldState>(); // Key for snackbar
  NetworkProvider networkProvider = NetworkProvider();
  String name, username, email, phone, password;
  List<DataRole> listRole = [];
  String _role = "";
  String _roleID = "";

  Future<void> onValidate() async {
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      BaseEndPoint baseEndPoint = NetworkProvider();
      bool isSuccess = await baseEndPoint.registerUser(name, username, phone, email, password, _roleID);
      if(isSuccess){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
      }else{
        scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("Register Failed, try another username or email"),
          )
        );
      }
    }
  }

  var _obSecure = true;
  void onHidePassword() {
    _obSecure ? _obSecure=false: _obSecure=true;
    setState(() {});
  }

  void getRole() async {
    await networkProvider.getRole().then((value) {
      setState(() {
        listRole = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: Colors.greenAccent,
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child: Image.asset("images/bg.png", fit: BoxFit.fill)),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset('images/absen.png'),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  onSaved: (value) => name = value,
                                  decoration: InputDecoration(
                                      hintText: 'Full Name',
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    onSaved: (value) => username = value,
                                    decoration: InputDecoration(
                                        hintText: 'Username',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        )),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    onSaved: (value) => email = value,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        hintText: 'Email',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        )),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    onSaved: (value) => phone = value,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: 'Number Phone',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        )),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    obscureText: _obSecure,
                                    validator: (val) => val.length < 6
                                        ? 'Password to short'
                                        : null,
                                    onSaved: (val) => password = val,
                                    decoration: InputDecoration(
                                        hintText: 'Password',
                                        suffixIcon: IconButton(
                                          icon: Icon(_obSecure? Icons.visibility: Icons.visibility_off,size: 25,),
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
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: Colors.black45, width: 1)),
                                  child: DropdownButtonHideUnderline(

                                    child: DropdownButton(
                                      isExpanded: true,
                                      hint: Text("Select Role", style: TextStyle(color: Colors.white)),
                                      value: _role==""? null:_role,
                                      items: listRole.map((e) {
                                        return DropdownMenuItem(
                                          value: e.nameRole,
                                          child: Text(e.nameRole,style: TextStyle(color: Colors.blue)),
                                          onTap: (){
                                            _role = e.nameRole;
                                            _roleID = e.idRole;
                                            setState(() {});
                                          },
                                        );
                                      }).toList(),
                                      onChanged: (String value) {
                                        _role = value;
                                      },
                                    ),

                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 16, bottom: 16),
                                  height: 50,
                                  width: double.infinity,
                                  child: RaisedButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    onPressed: () {
                                      onValidate();
                                      // push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
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
