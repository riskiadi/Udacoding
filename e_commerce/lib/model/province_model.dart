// To parse this JSON data, do
//
//     final provinceModel = provinceModelFromJson(jsonString);

import 'dart:convert';

List<ProvinceModel> provinceModelFromJson(String str) => List<ProvinceModel>.from(json.decode(str).map((x) => ProvinceModel.fromJson(x)));

String provinceModelToJson(List<ProvinceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProvinceModel {
    ProvinceModel({
        this.id,
        this.countryId,
        this.province,
    });

    int id;
    int countryId;
    String province;

    factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        id: json["id"] == null ? null : json["id"],
        countryId: json["country_id"] == null ? null : json["country_id"],
        province: json["province"] == null ? null : json["province"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "country_id": countryId == null ? null : countryId,
        "province": province == null ? null : province,
    };
}
