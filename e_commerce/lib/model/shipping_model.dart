// To parse this JSON data, do
//
//     final shippingModel = shippingModelFromJson(jsonString);

import 'dart:convert';

ShippingModel shippingModelFromJson(String str) => ShippingModel.fromJson(json.decode(str));

String shippingModelToJson(ShippingModel data) => json.encode(data.toJson());

class ShippingModel {
    ShippingModel({
        this.message,
        this.status,
        this.shipping,
    });

    String message;
    int status;
    List<Shipping> shipping;

    factory ShippingModel.fromJson(Map<String, dynamic> json) => ShippingModel(
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
        shipping: json["shipping"] == null ? null : List<Shipping>.from(json["shipping"].map((x) => Shipping.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "status": status == null ? null : status,
        "shipping": shipping == null ? null : List<dynamic>.from(shipping.map((x) => x.toJson())),
    };
}

class Shipping {
    Shipping({
        this.id,
        this.userId,
        this.title,
        this.city,
        this.province,
        this.address,
        this.zipCode,
        this.createdAt,
    });

    int id;
    int userId;
    String title;
    String city;
    String province;
    String address;
    String zipCode;
    DateTime createdAt;

    factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        title: json["title"] == null ? null : json["title"],
        city: json["city"] == null ? null : json["city"],
        province: json["province"] == null ? null : json["province"],
        address: json["address"] == null ? null : json["address"],
        zipCode: json["zip_code"] == null ? null : json["zip_code"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "title": title == null ? null : title,
        "city": city == null ? null : city,
        "province": province == null ? null : province,
        "address": address == null ? null : address,
        "zip_code": zipCode == null ? null : zipCode,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    };
}
