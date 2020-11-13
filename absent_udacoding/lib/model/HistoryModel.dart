// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

HistoryModel historyModelFromJson(String str) => HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
  HistoryModel({
    this.idUser,
    this.message,
    this.status,
    this.dataHistory,
  });

  String idUser;
  String message;
  int status;
  List<DataHistory> dataHistory;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    idUser: json["idUser"] == null ? null : json["idUser"],
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    dataHistory: json["dataHistory"] == null ? null : List<DataHistory>.from(json["dataHistory"].map((x) => DataHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "idUser": idUser == null ? null : idUser,
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "dataHistory": dataHistory == null ? null : List<dynamic>.from(dataHistory.map((x) => x.toJson())),
  };
}

class DataHistory {
  DataHistory({
    this.idAbsent,
    this.checkIn,
    this.checkOut,
    this.dateToday,
    this.place,
    this.checkInBy,
    this.checkOutBy,
    this.jamKerja,
    this.langLoc,
    this.longLoc,
    this.alamat,
    this.status,
    this.idUser,
  });

  String idAbsent;
  DateTime checkIn;
  DateTime checkOut;
  DateTime dateToday;
  String place;
  String checkInBy;
  String checkOutBy;
  String jamKerja;
  String langLoc;
  String longLoc;
  String alamat;
  String status;
  String idUser;

  factory DataHistory.fromJson(Map<String, dynamic> json) => DataHistory(
    idAbsent: json["id_absent"] == null ? null : json["id_absent"],
    checkIn: json["check_in"] == null ? null : DateTime.parse(json["check_in"]),
    checkOut: json["check_out"] == null ? null : DateTime.parse(json["check_out"]),
    dateToday: json["date_today"] == null ? null : DateTime.parse(json["date_today"]),
    place: json["place"] == null ? null : json["place"],
    checkInBy: json["check_in_by"] == null ? null : json["check_in_by"],
    checkOutBy: json["check_out_by"] == null ? null : json["check_out_by"],
    jamKerja: json["jam_kerja"] == null ? null : json["jam_kerja"],
    langLoc: json["lang_loc"] == null ? null : json["lang_loc"],
    longLoc: json["long_loc"] == null ? null : json["long_loc"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    status: json["status"] == null ? null : json["status"],
    idUser: json["id_user"] == null ? null : json["id_user"],
  );

  Map<String, dynamic> toJson() => {
    "id_absent": idAbsent == null ? null : idAbsent,
    "check_in": checkIn == null ? null : checkIn.toIso8601String(),
    "check_out": checkOut == null ? null : checkOut.toIso8601String(),
    "date_today": dateToday == null ? null : "${dateToday.year.toString().padLeft(4, '0')}-${dateToday.month.toString().padLeft(2, '0')}-${dateToday.day.toString().padLeft(2, '0')}",
    "place": place == null ? null : place,
    "check_in_by": checkInBy == null ? null : checkInBy,
    "check_out_by": checkOutBy == null ? null : checkOutBy,
    "jam_kerja": jamKerja == null ? null : jamKerja,
    "lang_loc": langLoc == null ? null : langLoc,
    "long_loc": longLoc == null ? null : longLoc,
    "alamat": alamat == null ? null : alamat,
    "status": status == null ? null : status,
    "id_user": idUser == null ? null : idUser,
  };
}
