// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.message,
        this.status,
        this.user,
    });

    String message;
    int status;
    User user;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "status": status == null ? null : status,
        "user": user == null ? null : user.toJson(),
    };
}

class User {
    User({
        this.userId,
        this.userNama,
        this.userEmail,
        this.userPassword,
        this.userHp,
        this.userStatus,
        this.userLevel,
        this.userToken,
        this.userTanggal,
        this.userImage,
    });

    int userId;
    String userNama;
    String userEmail;
    String userPassword;
    String userHp;
    int userStatus;
    int userLevel;
    dynamic userToken;
    DateTime userTanggal;
    String userImage;

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"] == null ? null : json["user_id"],
        userNama: json["user_nama"] == null ? null : json["user_nama"],
        userEmail: json["user_email"] == null ? null : json["user_email"],
        userPassword: json["user_password"] == null ? null : json["user_password"],
        userHp: json["user_hp"] == null ? null : json["user_hp"],
        userStatus: json["user_status"] == null ? null : json["user_status"],
        userLevel: json["user_level"] == null ? null : json["user_level"],
        userToken: json["user_token"],
        userTanggal: json["user_tanggal"] == null ? null : DateTime.parse(json["user_tanggal"]),
        userImage: json["user_image"] == null ? null : json["user_image"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "user_nama": userNama == null ? null : userNama,
        "user_email": userEmail == null ? null : userEmail,
        "user_password": userPassword == null ? null : userPassword,
        "user_hp": userHp == null ? null : userHp,
        "user_status": userStatus == null ? null : userStatus,
        "user_level": userLevel == null ? null : userLevel,
        "user_token": userToken,
        "user_tanggal": userTanggal == null ? null : userTanggal.toIso8601String(),
        "user_image": userImage == null ? null : userImage,
    };
}
