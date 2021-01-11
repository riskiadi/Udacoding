/// message : "success"
/// status : 200
/// invoice : [{"detail_id":23,"detail_order":"UDCODR-JMVCLWQ5ZC","detail_produk":7,"detail_qty":3,"detail_harga":5000,"detail_img":null,"detail_user":11,"detail_status":1,"detail_total":15000,"produk_nama":"produk 4","produk_gambar":"gambar4.jpeg"},{"detail_id":24,"detail_order":"UDCODR-JMVCLWQ5ZC","detail_produk":7,"detail_qty":2,"detail_harga":5000,"detail_img":null,"detail_user":11,"detail_status":1,"detail_total":10000,"produk_nama":"produk 4","produk_gambar":"gambar4.jpeg"},{"detail_id":25,"detail_order":"UDCODR-JMVCLWQ5ZC","detail_produk":1,"detail_qty":1,"detail_harga":120000,"detail_img":null,"detail_user":11,"detail_status":1,"detail_total":131000,"produk_nama":"produk1","produk_gambar":"gambar1.jpeg"},{"detail_id":27,"detail_order":"UDCODR-JMVCLWQ5ZC","detail_produk":1,"detail_qty":1,"detail_harga":120000,"detail_img":null,"detail_user":11,"detail_status":1,"detail_total":131000,"produk_nama":"produk1","produk_gambar":"gambar1.jpeg"},{"detail_id":31,"detail_order":"UDCODR-JMVCLWQ5ZC","detail_produk":10,"detail_qty":10,"detail_harga":5000,"detail_img":null,"detail_user":11,"detail_status":1,"detail_total":61000,"produk_nama":"produk 7 ","produk_gambar":"gambar7.jpeg"}]

class InvoiceModel {
  String _message;
  int _status;
  List<Invoice> _invoice;

  String get message => _message;
  int get status => _status;
  List<Invoice> get invoice => _invoice;

  InvoiceModel({
      String message, 
      int status, 
      List<Invoice> invoice}){
    _message = message;
    _status = status;
    _invoice = invoice;
}

  InvoiceModel.fromJson(dynamic json) {
    _message = json["message"];
    _status = json["status"];
    if (json["invoice"] != null) {
      _invoice = [];
      json["invoice"].forEach((v) {
        _invoice.add(Invoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    map["status"] = _status;
    if (_invoice != null) {
      map["invoice"] = _invoice.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// detail_id : 23
/// detail_order : "UDCODR-JMVCLWQ5ZC"
/// detail_produk : 7
/// detail_qty : 3
/// detail_harga : 5000
/// detail_img : null
/// detail_user : 11
/// detail_status : 1
/// detail_total : 15000
/// produk_nama : "produk 4"
/// produk_gambar : "gambar4.jpeg"

class Invoice {
  int _detailId;
  String _detailOrder;
  int _detailProduk;
  int _detailQty;
  int _detailHarga;
  dynamic _detailImg;
  int _detailUser;
  int _detailStatus;
  int _detailTotal;
  String _produkNama;
  String _produkGambar;

  int get detailId => _detailId;
  String get detailOrder => _detailOrder;
  int get detailProduk => _detailProduk;
  int get detailQty => _detailQty;
  int get detailHarga => _detailHarga;
  dynamic get detailImg => _detailImg;
  int get detailUser => _detailUser;
  int get detailStatus => _detailStatus;
  int get detailTotal => _detailTotal;
  String get produkNama => _produkNama;
  String get produkGambar => _produkGambar;

  Invoice({
      int detailId, 
      String detailOrder, 
      int detailProduk, 
      int detailQty, 
      int detailHarga, 
      dynamic detailImg, 
      int detailUser, 
      int detailStatus, 
      int detailTotal, 
      String produkNama, 
      String produkGambar}){
    _detailId = detailId;
    _detailOrder = detailOrder;
    _detailProduk = detailProduk;
    _detailQty = detailQty;
    _detailHarga = detailHarga;
    _detailImg = detailImg;
    _detailUser = detailUser;
    _detailStatus = detailStatus;
    _detailTotal = detailTotal;
    _produkNama = produkNama;
    _produkGambar = produkGambar;
}

  Invoice.fromJson(dynamic json) {
    _detailId = json["detail_id"];
    _detailOrder = json["detail_order"];
    _detailProduk = json["detail_produk"];
    _detailQty = json["detail_qty"];
    _detailHarga = json["detail_harga"];
    _detailImg = json["detail_img"];
    _detailUser = json["detail_user"];
    _detailStatus = json["detail_status"];
    _detailTotal = json["detail_total"];
    _produkNama = json["produk_nama"];
    _produkGambar = json["produk_gambar"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["detail_id"] = _detailId;
    map["detail_order"] = _detailOrder;
    map["detail_produk"] = _detailProduk;
    map["detail_qty"] = _detailQty;
    map["detail_harga"] = _detailHarga;
    map["detail_img"] = _detailImg;
    map["detail_user"] = _detailUser;
    map["detail_status"] = _detailStatus;
    map["detail_total"] = _detailTotal;
    map["produk_nama"] = _produkNama;
    map["produk_gambar"] = _produkGambar;
    return map;
  }

}