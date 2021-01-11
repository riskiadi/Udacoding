// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

List<CityModel> cityModelFromJson(String str) => List<CityModel>.from(json.decode(str).map((x) => CityModel.fromJson(x)));

String cityModelToJson(List<CityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityModel {
    CityModel({
        this.id,
        this.provinceId,
        this.city,
        this.type,
        this.postalCode,
        this.status,
    });

    int id;
    int provinceId;
    String city;
    String type;
    String postalCode;
    int status;

    factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"] == null ? null : json["id"],
        provinceId: json["province_id"] == null ? null : json["province_id"],
        city: json["city"] == null ? null : json["city"],
        type: json["type"] == null ? null : json["type"],
        postalCode: json["postal_code"] == null ? null : json["postal_code"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "province_id": provinceId == null ? null : provinceId,
        "city": city == null ? null : city,
        "type": type == null ? null : type,
        "postal_code": postalCode == null ? null : postalCode,
        "status": status == null ? null : status,
    };
}
