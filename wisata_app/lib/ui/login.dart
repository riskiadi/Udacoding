import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_app/repository.dart';
import 'package:wisata_app/ui/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/image/google.png', width: 130,),
                SizedBox(height:  20),
                RaisedButton(
                  color: Color(0xff4285F4),
                    child: Text("Login With Google", style: TextStyle(color: Colors.white),),
                    onPressed: (){

                      _userRepository.handleSignIn().then((googleAccount){
                        _saveData().then((value){
                          value.setString("name", googleAccount.displayName);
                          value.setString("email", googleAccount.email);
                          value.setString("photo", googleAccount.photoUrl);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
                        });
                      });

                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<SharedPreferences> _saveData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

}
