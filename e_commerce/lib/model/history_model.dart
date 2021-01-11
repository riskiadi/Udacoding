// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

HistoryModel historyModelFromJson(String str) => HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
    HistoryModel({
        this.message,
        this.status,
        this.dataHistory,
    });

    String message;
    bool status;
    List<DataHistory> dataHistory;

    factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
        dataHistory: json["dataHistory"] == null ? null : List<DataHistory>.from(json["dataHistory"].map((x) => DataHistory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "status": status == null ? null : status,
        "dataHistory": dataHistory == null ? null : List<dynamic>.from(dataHistory.map((x) => x.toJson())),
    };
}

class DataHistory {
    DataHistory({
        this.detailId,
        this.detailOrder,
        this.detailProduk,
        this.detailQty,
        this.detailHarga,
        this.detailImg,
        this.detailUser,
        this.detailStatus,
        this.detailTotal,
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
        this.orderId,
        this.orderTanggal,
        this.orderUser,
        this.orderAlamatUser,
        this.orderStatus,
        this.orderTotal,
        this.idcheckout,
    });

    int detailId;
    String detailOrder;
    int detailProduk;
    int detailQty;
    int detailHarga;
    String detailImg;
    int detailUser;
    int detailStatus;
    int detailTotal;
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
    int isPromote;
    DateTime createdAt;
    DateTime updatedAt;
    int orderId;
    DateTime orderTanggal;
    int orderUser;
    String orderAlamatUser;
    int orderStatus;
    String orderTotal;
    String idcheckout;

    factory DataHistory.fromJson(Map<String, dynamic> json) => DataHistory(
        detailId: json["detail_id"] == null ? null : json["detail_id"],
        detailOrder: json["detail_order"] == null ? null : json["detail_order"],
        detailProduk: json["detail_produk"] == null ? null : json["detail_produk"],
        detailQty: json["detail_qty"] == null ? null : json["detail_qty"],
        detailHarga: json["detail_harga"] == null ? null : json["detail_harga"],
        detailImg: json["detail_img"] == null ? null : json["detail_img"],
        detailUser: json["detail_user"] == null ? null : json["detail_user"],
        detailStatus: json["detail_status"] == null ? null : json["detail_status"],
        detailTotal: json["detail_total"] == null ? null : json["detail_total"],
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
        orderId: json["order_id"] == null ? null : json["order_id"],
        orderTanggal: json["order_tanggal"] == null ? null : DateTime.parse(json["order_tanggal"]),
        orderUser: json["order_user"] == null ? null : json["order_user"],
        orderAlamatUser: json["order_alamatUser"] == null ? null : json["order_alamatUser"],
        orderStatus: json["order_status"] == null ? null : json["order_status"],
        orderTotal: json["order_total"] == null ? null : json["order_total"],
        idcheckout: json["idcheckout"] == null ? null : json["idcheckout"],
    );

    Map<String, dynamic> toJson() => {
        "detail_id": detailId == null ? null : detailId,
        "detail_order": detailOrder == null ? null : detailOrder,
        "detail_produk": detailProduk == null ? null : detailProduk,
        "detail_qty": detailQty == null ? null : detailQty,
        "detail_harga": detailHarga == null ? null : detailHarga,
        "detail_img": detailImg == null ? null : detailImg,
        "detail_user": detailUser == null ? null : detailUser,
        "detail_status": detailStatus == null ? null : detailStatus,
        "detail_total": detailTotal == null ? null : detailTotal,
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
        "order_id": orderId == null ? null : orderId,
        "order_tanggal": orderTanggal == null ? null : orderTanggal.toIso8601String(),
        "order_user": orderUser == null ? null : orderUser,
        "order_alamatUser": orderAlamatUser == null ? null : orderAlamatUser,
        "order_status": orderStatus == null ? null : orderStatus,
        "order_total": orderTotal == null ? null : orderTotal,
        "idcheckout": idcheckout == null ? null : idcheckout,
    };
}
