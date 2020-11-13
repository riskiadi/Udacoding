import 'dart:convert';
import 'dart:io';
import 'package:absent_udacoding/model/HistoryModel.dart';
import 'package:absent_udacoding/model/ModelUpdate.dart';
import 'package:async/async.dart';
import 'dart:async';
import 'package:absent_udacoding/DashboardPage.dart';
import 'package:absent_udacoding/constant/ConstantFile.dart';
import 'package:absent_udacoding/model/ModelAbsent.dart';
import 'package:absent_udacoding/model/ModelRole.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;

abstract class BaseEndPoint {
  Future<List> loginUser(String myUsername, String myPassword, BuildContext context);
  Future<bool> registerUser(String name, String username, String phone, String email, String password, String role);
  Future<List> getAbsent(String myId);
  Future<List> getDetail(String myId);
  Future checkIn(String idUser, String check_in_by, String place, double lat, double long);
  void checkOut(String idAbsent, String check_out_by, String idUser, String jam_kerja);
  Future<List> getRole();
  Future<List> getHistory(String idUser);
  void updateImage(String idUser, File imageUser);
  void updateProfile(String idUser, String myUsername, String myEmail, String myRole, String myPhone);
}

class NetworkProvider extends BaseEndPoint {
  @override
  Future<List> loginUser(
      String myUsername, String myPassword, BuildContext context) async {
    // TODO: implement loginUser
    print("username" + myUsername);
    print("password" + myPassword);
    final response = await http.post(ConstantFile().baseUrl + "loginUser", body: {'username': myUsername, 'password': myPassword});

    ModelRole listData = modelRoleFromJson(response.body);
    if (listData.status == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashboardPage()));
      return listData?.user;
    } else {
      print(listData.message);
      return null;
    }
  }


  @override
  Future<List> getAbsent(String myId) async {
    // TODO: implement getAbsent
    final response = await http.post(ConstantFile().baseUrl + "getAbsent", body: {'iduser': myId});
    ModelAbsent listData = modelAbsentFromJson(response.body);
    print(listData);
    return listData.absent;
  }

  @override
  Future checkIn(String idUser, String check_in_by, String place, double lat, double long) async {
    // TODO: implement checkIn
    final coordinates = new Coordinates(lat, long);
    List<Address> address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    final response = await http.post(ConstantFile().baseUrl + "checkIn", body: {
      'iduser': idUser,
      'check_in_by': check_in_by,
      'place': address.first.subAdminArea,
      'lang_loc' : lat.toString(),
      'long_loc' : long.toString()
    });

    var listData = jsonDecode(response.body);
    if (listData['status'] == 200) {
      print(listData['message']);
    } else {
      print(listData['message']);
    }
  }

  @override
  Future<List> getDetail(String myId) async {
    // TODO: implement getDetail
    final response = await http.post(ConstantFile().baseUrl + "getDetail", body: {'iduser': myId});

//    var listData = jsonDecode(response.body);
    ModelAbsent listData = modelAbsentFromJson(response.body);
    print(listData);
    return listData.absent;
  }

  @override
  void updateProfile(String idUser, String myUsername, String myEmail,
      String myRole, String myPhone) async {
    // TODO: implement updateProfile
    final response =
        await http.post(ConstantFile().baseUrl + "updateProfile", body: {
      'iduser': idUser,
      'username': myUsername,
      'idrole': myRole,
      'email': myEmail,
      'phone': myPhone,
    });

    var listData = jsonDecode(response.body);
    if (listData['status'] == 200) {
      print(listData['message']);
    } else {
      print(listData['message']);
    }
  }

  @override
  void updateImage(String idUser, File imageUser) async {
    // TODO: implement updateImage
    var stream = http.ByteStream(DelegatingStream.typed(imageUser.openRead()));
    var length = await imageUser.length();
    var request = http.MultipartRequest(
        'POST', Uri.parse(ConstantFile().baseUrl + 'updateImage'));

    var multipart =
        http.MultipartFile('image', stream, length, filename: imageUser.path);
    request.files.add(multipart);
    request.fields['iduser'] = idUser;
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Image Uploaded');
    } else {
      print('Image Failed Uploaded');
    }
  }

  @override
  Future<List> getRole() async {
    // TODO: implement getRole
    final response = await http.post(ConstantFile().baseUrl + "getRole");

    ModelUpdate listData = modelUpdateFromJson(response.body);
    return listData.dataRole;
  }

  @override
  void checkOut(String idAbsent, String check_out_by, String idUser,
      String jam_kerja) async {
    // TODO: implement checkOut
    final response =
        await http.post(ConstantFile().baseUrl + "checkOut", body: {
      'id_absent': idAbsent,
      'check_out_by': check_out_by,
      'iduser': idUser,
      'jam_kerja': jam_kerja,
    });

    var listData = jsonDecode(response.body);
    if (listData['status'] == 200) {
      print(listData['message']);
    } else {
      print(listData['message']);
    }
  }

  @override
  Future<List> getHistory(String idUser) async {
    final response = await http.post(ConstantFile().baseUrl + "getHistoryById",
        body: {'iduser': idUser});
    var listData = historyModelFromJson(response.body);
    return listData.dataHistory;
  }

  @override
  Future<bool> registerUser(String name, String username, String phone, String email, String password, String role) async{
    var response = await http.post(ConstantFile().baseUrl + "registerUser", body: {
      "name" : name,
      "username" : username,
      "phone" : phone,
      "email" : email,
      "password" : password,
      "role" : role,
    });
    if(jsonDecode(response.body)["status"] != 404){
      return true;
    }else{
      return false;
    }
  }

}

//  @override
//  Future<List> getRole(String myId) async{
//    // TODO: implement getRole
//    final response = await http.post(ConstantFile().baseUrl+"getRole", body: {
//      'idrole' : myId
//    });
//    ModelRole listData = modelRoleFromJson(response.body);
//    print(listData);
//    return listData.role;
//  }
