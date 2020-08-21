// To parse this JSON data, do
//
//     final dictionary = dictionaryFromJson(jsonString);

import 'dart:convert';

List<Dictionary> dictionaryFromJson(String str) => List<Dictionary>.from(json.decode(str).map((x) => Dictionary.fromJson(x)));

String dictionaryToJson(List<Dictionary> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dictionary {

  String indonesia;
  String arabic;
  String pronounce;

  Dictionary({
    this.indonesia,
    this.arabic,
    this.pronounce,
  });

  factory Dictionary.fromJson(Map<String, dynamic> json) => Dictionary(
    indonesia: json["indonesia"],
    arabic: json["arabic"],
    pronounce: json["pronounce"],
  );

  Map<String, dynamic> toJson() => {
    "indonesia": indonesia,
    "arabic": arabic,
    "pronounce": pronounce,
  };
}
