// To parse this JSON data, do
//
//     final modelRole = modelRoleFromJson(jsonString);

import 'dart:convert';

ModelRole modelRoleFromJson(String str) => ModelRole.fromJson(json.decode(str));

String modelRoleToJson(ModelRole data) => json.encode(data.toJson());

class ModelRole {
  String message;
  int status;
  List<User> user;

  ModelRole({
    this.message,
    this.status,
    this.user,
  });

  factory ModelRole.fromJson(Map<String, dynamic> json) => ModelRole(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    user: json["user"] == null ? null : List<User>.from(json["user"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "user": user == null ? null : List<dynamic>.from(user.map((x) => x.toJson())),
  };
}

class User {
  String idUser;
  String fullnameUser;
  String emailUser;
  String phoneUser;
  String photoUser;
  String place;
  String usernameUser;
  String passwordUser;
  DateTime checkIn;
  DateTime checkOut;
  String idRole;
  String nameRole;

  User({
    this.idUser,
    this.fullnameUser,
    this.emailUser,
    this.phoneUser,
    this.photoUser,
    this.place,
    this.usernameUser,
    this.passwordUser,
    this.checkIn,
    this.checkOut,
    this.idRole,
    this.nameRole,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    idUser: json["id_user"] == null ? null : json["id_user"],
    fullnameUser: json["fullname_user"] == null ? null : json["fullname_user"],
    emailUser: json["email_user"] == null ? null : json["email_user"],
    phoneUser: json["phone_user"] == null ? null : json["phone_user"],
    photoUser: json["photo_user"] == null ? null : json["photo_user"],
    place: json["place"] == null ? null : json["place"],
    usernameUser: json["username_user"] == null ? null : json["username_user"],
    passwordUser: json["password_user"] == null ? null : json["password_user"],
    checkIn: json["check_in"] == null ? null : DateTime.parse(json["check_in"]),
    checkOut: json["check_out"] == null ? null : DateTime.parse(json["check_out"]),
    idRole: json["id_role"] == null ? null : json["id_role"],
    nameRole: json["name_role"] == null ? null : json["name_role"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser == null ? null : idUser,
    "fullname_user": fullnameUser == null ? null : fullnameUser,
    "email_user": emailUser == null ? null : emailUser,
    "phone_user": phoneUser == null ? null : phoneUser,
    "photo_user": photoUser == null ? null : photoUser,
    "place": place == null ? null : place,
    "username_user": usernameUser == null ? null : usernameUser,
    "password_user": passwordUser == null ? null : passwordUser,
    "check_in": checkIn == null ? null : checkIn.toIso8601String(),
    "check_out": checkOut == null ? null : checkOut.toIso8601String(),
    "id_role": idRole == null ? null : idRole,
    "name_role": nameRole == null ? null : nameRole,
  };
}
