// To parse this JSON data, do
//
//     final noteUpdate = noteUpdateFromJson(jsonString);

import 'dart:convert';

NoteUpdate noteUpdateFromJson(String str) => NoteUpdate.fromJson(json.decode(str));

String noteUpdateToJson(NoteUpdate data) => json.encode(data.toJson());

class NoteUpdate {
  NoteUpdate({
    this.value,
    this.message,
  });

  final int value;
  final String message;

  factory NoteUpdate.fromJson(Map<String, dynamic> json) => NoteUpdate(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
