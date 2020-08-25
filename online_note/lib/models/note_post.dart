// To parse this JSON data, do
//
//     final notePost = notePostFromJson(jsonString);

import 'dart:convert';

NotePost notePostFromJson(String str) => NotePost.fromJson(json.decode(str));

String notePostToJson(NotePost data) => json.encode(data.toJson());

class NotePost {
  NotePost({
    this.value,
    this.message,
  });

  final int value;
  final String message;

  factory NotePost.fromJson(Map<String, dynamic> json) => NotePost(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
