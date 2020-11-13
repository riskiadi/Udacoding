import 'package:shared_preferences/shared_preferences.dart';

abstract class RuleUtils {
  void savePreference(bool status, String idUser, String fullnameUser, String emailUser, String phoneUser,
      String photoUser, String usernameUser, String namaRole);
  Future getPreference();
}

class SessionManager extends RuleUtils {
  var globIduser, globName, globEmail, globPhone, globPhoto, globUsername, globRole; //untuk inputan
  var globStatus;

  @override
  Future getPreference() async{
    // TODO: implement getPreference
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    globStatus = sharedPreferences.getBool("myStatus");
    globIduser = sharedPreferences.get("myIduser");
    globName = sharedPreferences.getString("myName");
    globEmail = sharedPreferences.getString("myEmail");
    globPhone = sharedPreferences.getString("myPhone");
    globPhoto = sharedPreferences.getString("myPhoto");
    globUsername = sharedPreferences.getString("myUsername");
    globRole = sharedPreferences.getString("myNameRole");
  }

  @override
  void savePreference(bool status, String idUser, String fullnameUser, String emailUser, String phoneUser, String photoUser, String usernameUser, String namaRole) async{
    // TODO: implement savePreference
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("myStatus", status);
    sharedPreferences.setString("myIduser", idUser);
    sharedPreferences.setString("myName", fullnameUser);
    sharedPreferences.setString("myEmail", emailUser);
    sharedPreferences.setString("myPhone", phoneUser);
    sharedPreferences.setString("myPhoto", photoUser);
    sharedPreferences.setString("myUsername", usernameUser);
    sharedPreferences.setString("myNameRole", namaRole);
    sharedPreferences.commit();
  } //untuk pembacaan

}
