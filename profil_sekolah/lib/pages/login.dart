import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:profil_sekolah/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GoogleSignIn _signIn = GoogleSignIn();
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    _signIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    _signIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login with Google'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(
              child: RaisedButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/google.png', width: 30, height: 30,),
                    SizedBox(width: 10,),
                    Text('Sign In'),
                  ],
                ),
                onPressed: (){
                  _handleSignIn();
                },
              ),
            ),
            
            Text(_currentUser?.displayName ?? ''),
            Text(_currentUser?.id ?? ''),
            
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    try{
      var user = await _signIn.signIn();
      _saveData(user.displayName, user.photoUrl, user.email);
    }catch(e){
      print(e);
    }
  }

  Future<void> _handleSignOut() => _signIn.disconnect();

  _saveData(String name, String photo, String email) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('name', name);
    sharedPreferences.setString('email', email);
    sharedPreferences.setString('photo', photo);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
  }

}
