// To parse this JSON data, do
//
//     final modelUpdate = modelUpdateFromJson(jsonString);

import 'dart:convert';

ModelUpdate modelUpdateFromJson(String str) => ModelUpdate.fromJson(json.decode(str));

String modelUpdateToJson(ModelUpdate data) => json.encode(data.toJson());

class ModelUpdate {
  String message;
  int status;
  List<DataRole> dataRole;

  ModelUpdate({
    this.message,
    this.status,
    this.dataRole,
  });

  factory ModelUpdate.fromJson(Map<String, dynamic> json) => ModelUpdate(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    dataRole: json["dataRole"] == null ? null : List<DataRole>.from(json["dataRole"].map((x) => DataRole.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "dataRole": dataRole == null ? null : List<dynamic>.from(dataRole.map((x) => x.toJson())),
  };
}

class DataRole {
  String idRole;
  String nameRole;

  DataRole({
    this.idRole,
    this.nameRole,
  });

  factory DataRole.fromJson(Map<String, dynamic> json) => DataRole(
    idRole: json["id_role"] == null ? null : json["id_role"],
    nameRole: json["name_role"] == null ? null : json["name_role"],
  );

  Map<String, dynamic> toJson() => {
    "id_role": idRole == null ? null : idRole,
    "name_role": nameRole == null ? null : nameRole,
  };
}
