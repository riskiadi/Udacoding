// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    ProductModel({
        this.message,
        this.status,
        this.dataProduct,
    });

    String message;
    int status;
    List<DataProduct> dataProduct;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
        dataProduct: json["dataProduct"] == null ? null : List<DataProduct>.from(json["dataProduct"].map((x) => DataProduct.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "status": status == null ? null : status,
        "dataProduct": dataProduct == null ? null : List<dynamic>.from(dataProduct.map((x) => x.toJson())),
    };
}

class DataProduct {
    DataProduct({
        this.produkId,
        this.produkNama,
        this.produkStok,
        this.produkGrowback,
        this.produkStatus,
        this.produkHarga,
        this.produkTanggal,
        this.deskripsiProduk,
        this.produkGambar,
        this.produkKategori,
        this.produkRating,
        this.isPromote,
        this.createdAt,
        this.updatedAt,
    });

    int produkId;
    String produkNama;
    int produkStok;
    int produkGrowback;
    int produkStatus;
    int produkHarga;
    DateTime produkTanggal;
    String deskripsiProduk;
    String produkGambar;
    int produkKategori;
    int produkRating;
    bool isPromote;
    DateTime createdAt;
    DateTime updatedAt;

    factory DataProduct.fromJson(Map<String, dynamic> json) => DataProduct(
        produkId: json["produk_id"] == null ? null : json["produk_id"],
        produkNama: json["produk_nama"] == null ? null : json["produk_nama"],
        produkStok: json["produk_stok"] == null ? null : json["produk_stok"],
        produkGrowback: json["produk_growback"] == null ? null : json["produk_growback"],
        produkStatus: json["produk_status"] == null ? null : json["produk_status"],
        produkHarga: json["produk_harga"] == null ? null : json["produk_harga"],
        produkTanggal: json["produk_tanggal"] == null ? null : DateTime.parse(json["produk_tanggal"]),
        deskripsiProduk: json["deskripsi_produk"] == null ? null : json["deskripsi_produk"],
        produkGambar: json["produk_gambar"] == null ? null : json["produk_gambar"],
        produkKategori: json["produk_kategori"] == null ? null : json["produk_kategori"],
        produkRating: json["produk_rating"] == null ? null : json["produk_rating"],
        isPromote: json["is_promote"] == null ? null : json["is_promote"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "produk_id": produkId == null ? null : produkId,
        "produk_nama": produkNama == null ? null : produkNama,
        "produk_stok": produkStok == null ? null : produkStok,
        "produk_growback": produkGrowback == null ? null : produkGrowback,
        "produk_status": produkStatus == null ? null : produkStatus,
        "produk_harga": produkHarga == null ? null : produkHarga,
        "produk_tanggal": produkTanggal == null ? null : produkTanggal.toIso8601String(),
        "deskripsi_produk": deskripsiProduk == null ? null : deskripsiProduk,
        "produk_gambar": produkGambar == null ? null : produkGambar,
        "produk_kategori": produkKategori == null ? null : produkKategori,
        "produk_rating": produkRating == null ? null : produkRating,
        "is_promote": isPromote == null ? null : isPromote,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
