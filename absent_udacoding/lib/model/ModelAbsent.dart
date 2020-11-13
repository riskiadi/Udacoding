// To parse this JSON data, do
//
//     final modelAbsent = modelAbsentFromJson(jsonString);

import 'dart:convert';

ModelAbsent modelAbsentFromJson(String str) => ModelAbsent.fromJson(json.decode(str));

String modelAbsentToJson(ModelAbsent data) => json.encode(data.toJson());

class ModelAbsent {
  String message;
  int status;
  List<Absent> absent;

  ModelAbsent({
    this.message,
    this.status,
    this.absent,
  });

  factory ModelAbsent.fromJson(Map<String, dynamic> json) => ModelAbsent(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    absent: json["absent"] == null ? null : List<Absent>.from(json["absent"].map((x) => Absent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "absent": absent == null ? null : List<dynamic>.from(absent.map((x) => x.toJson())),
  };
}

class Absent {
  String idUser;
  String fullnameUser;
  String emailUser;
  String phoneUser;
  String photoUser;
  String usernameUser;
  String passwordUser;
  String idRole;
  String nameRole;
  String idAbsent;
  String checkIn;
  String checkOut;
  String place;
  String latitude;
  String longitude;

  Absent({
    this.idUser,
    this.fullnameUser,
    this.emailUser,
    this.phoneUser,
    this.photoUser,
    this.usernameUser,
    this.passwordUser,
    this.idRole,
    this.nameRole,
    this.idAbsent,
    this.checkIn,
    this.checkOut,
    this.place,
    this.latitude,
    this.longitude,
  });

  factory Absent.fromJson(Map<String, dynamic> json) => Absent(
    idUser: json["id_user"] == null ? null : json["id_user"],
    fullnameUser: json["fullname_user"] == null ? null : json["fullname_user"],
    emailUser: json["email_user"] == null ? null : json["email_user"],
    phoneUser: json["phone_user"] == null ? null : json["phone_user"],
    photoUser: json["photo_user"] == null ? null : json["photo_user"],
    usernameUser: json["username_user"] == null ? null : json["username_user"],
    passwordUser: json["password_user"] == null ? null : json["password_user"],
    idRole: json["id_role"] == null ? null : json["id_role"],
    nameRole: json["name_role"] == null ? null : json["name_role"],
    idAbsent: json["id_absent"] == null ? null : json["id_absent"],
    checkIn: json["check_in"] == null ? null : json["check_in"],
    checkOut: json["check_out"] == null ? null : json["check_out"],
    place: json["place"] == null ? null : json["place"],
    latitude: json["latitude"] == null ? null : json["lang_loc"],
    longitude: json["longitude"] == null ? null : json["long_loc"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser == null ? null : idUser,
    "fullname_user": fullnameUser == null ? null : fullnameUser,
    "email_user": emailUser == null ? null : emailUser,
    "phone_user": phoneUser == null ? null : phoneUser,
    "photo_user": photoUser == null ? null : photoUser,
    "username_user": usernameUser == null ? null : usernameUser,
    "password_user": passwordUser == null ? null : passwordUser,
    "id_role": idRole == null ? null : idRole,
    "name_role": nameRole == null ? null : nameRole,
    "id_absent": idAbsent == null ? null : idAbsent,
    "check_in": checkIn == null ? null : checkIn,
    "check_out": checkOut == null ? null : checkOut,
    "place": place == null ? null : place,
    "lang_loc": place == null ? null : place,
    "long_loc": place == null ? null : place,
  };
}
