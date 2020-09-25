// To parse this JSON data, do
//
//     final pushModel = pushModelFromJson(jsonString);

import 'dart:convert';

PushModel pushModelFromJson(String str) => PushModel.fromJson(json.decode(str));

String pushModelToJson(PushModel data) => json.encode(data.toJson());

class PushModel {

  final String address;
  final String description;
  final List<String> images;
  final double latitude;
  final String locationName;
  final double longitude;

  PushModel({
    this.address,
    this.description,
    this.images,
    this.latitude,
    this.locationName,
    this.longitude,
  });

  factory PushModel.fromJson(Map<String, dynamic> json) => PushModel(
    address: json["address"],
    description: json["description"],
    images: List<String>.from(json["images"].map((x) => x)),
    latitude: json["latitude"].toDouble(),
    locationName: json["location_name"],
    longitude: json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "description": description,
    "images": List<dynamic>.from(images.map((x) => x)),
    "latitude": latitude,
    "location_name": locationName,
    "longitude": longitude,
  };
}
