// To parse this JSON data, do
//
//     final noteGet = noteGetFromJson(jsonString);

import 'dart:convert';

NoteGet noteGetFromJson(String str) => NoteGet.fromJson(json.decode(str));

String noteGetToJson(NoteGet data) => json.encode(data.toJson());

class NoteGet {
  NoteGet({
    this.value,
    this.message,
    this.notes,
  });

  final int value;
  final String message;
  final List<Note> notes;

  factory NoteGet.fromJson(Map<String, dynamic> json) => NoteGet(
    value: json["value"],
    message: json["message"],
    notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
    "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
  };
}

class Note {
  Note({
    this.id,
    this.title,
    this.note,
    this.timestamp,
  });

  final String id;
  final String title;
  final String note;
  final String timestamp;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json["id"],
    title: json["title"],
    note: json["note"],
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "note": note,
    "timestamp": timestamp,
  };
}