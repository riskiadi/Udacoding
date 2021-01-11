import 'dart:convert';
import 'package:e_commerce/model/city_model.dart';
import 'package:e_commerce/model/history_model.dart';
import 'package:e_commerce/model/invoice_model.dart';
import 'package:e_commerce/model/keranjang_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/model/province_model.dart';
import 'package:e_commerce/model/shipping_model.dart';
import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:e_commerce/utils/session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkRepo {

  Future getHistory()async{
    User userData = await sessionManager.getUser();
    try {
      final response = await http.post(baseUrl + "getHistory", body: {
        'iduser': "${userData.userId}",
      });
      if (response.statusCode == 200 && historyModelFromJson(response.body).status == true) {
        return historyModelFromJson(response.body).dataHistory;
      } else {
        return null;
      }
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }


  Future checkoutKeranjang(addressOrder, int total) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User userData = await sessionManager.getUser();
    var codeOrder = prefs.getString("code");
    try {
      final response = await http.post(baseUrl + "checkoutOrder", body: {
        'code': '$codeOrder',
        'iduser': '${userData.userId}',
        'alamat': '$addressOrder',
        'total': '$total',
      });
      if (response.statusCode == 200 &&
          jsonDecode(response.body)['status'] == true) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }

  Future getCity(id) async {
    try {
      final response = await http.post(baseUrl + "getCity", body: {
        'id': "$id",
      });
      if (response.statusCode == 200 &&
          cityModelFromJson(response.body) != null) {
        return cityModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }

  Future getProvince() async {
    try {
      final response = await http.post(baseUrl + "getProvince");
      if (response.statusCode == 200 &&
          provinceModelFromJson(response.body) != null) {
        return provinceModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }

  Future addShipping(Shipping dataShipping, String status) async {
    User userData = await sessionManager.getUser();
    var endpoint =
        status != null ? "updateShippingAddress" : "addShippingAddress";
    try {
      final response = await http.post(baseUrl + endpoint, body: {
        'user_id': '${userData.userId}',
        'title': dataShipping.title,
        'address': dataShipping.address,
        'province': dataShipping.province,
        'city': dataShipping.city,
        'zip_code': dataShipping.zipCode,
        'id': "${dataShipping.id}"
      });
      if (response.statusCode == 200 &&
          jsonDecode(response.body)['message'] == true) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }

  Future getShipping() async {
    User userData = await sessionManager.getUser();
    try {
      final response = await http.post(baseUrl + "getDataShipping", body: {
        'iduser': '${userData.userId}',
      });
      if (response.statusCode == 200 &&
          shippingModelFromJson(response.body).status == 200) {
        return shippingModelFromJson(response.body).shipping;
      } else {
        return null;
      }
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }

  Future updateQty(qty, total, detailId) async {
    try {
      final response = await http.post(baseUrl + "updateQty", body: {
        'qty': '$qty',
        'total': '$total',
        'detailid': '$detailId',
      });
      if (response.statusCode == 200 &&
          keranjangModelFromJson(response.body).status == true) {
        return keranjangModelFromJson(response.body).dataKeranjang;
      } else {
        return null;
      }
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }

  Future getKeranjang() async {
    User userData = await sessionManager.getUser();
    try {
      final response = await http.post(baseUrl + "getKeranjang", body: {
        'iduser': "${userData.userId}",
      });
      if (response.statusCode == 200 && keranjangModelFromJson(response.body).status == true) {
        return keranjangModelFromJson(response.body).dataKeranjang;
      } else {
        return null;
      }
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }

  Future loginUser(User userData) async {
    try {
      final response = await http.post(baseUrl + "loginCustomer", body: {
        'email': userData.userEmail,
        'password': userData.userPassword,
      });
      print(jsonDecode(response.body));
      if (response.statusCode == 200 &&
          userModelFromJson(response.body).status == 200) {
        return userModelFromJson(response.body).user;
      } else {
        return null;
      }
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }

  Future registerUser(User userData) async {
    try {
      final response = await http.post(baseUrl + "registerCustomer", body: {
        'nama': userData.userNama,
        'email': userData.userEmail,
        'hp': userData.userHp,
        'password': userData.userPassword,
      });
      if (response.statusCode == 200 &&
          userModelFromJson(response.body).status == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }

  Future addCart(DataProduct data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User userData = await sessionManager.getUser();
    var codeOrder = prefs.getString("code");
    if (codeOrder == null) {
      codeOrder = "UDCODR-${generateCode(10)}".toUpperCase();
      prefs.setString("code", codeOrder);
    }

    try {
      final response = await http.post(baseUrl + "addCart", body: {
        'code': codeOrder,
        'qty': "1",
        'idproduct': "${data.produkId}",
        'price': "${data.produkHarga}",
        'iduser': "${userData?.userId}",
      });
      if (response.statusCode == 200 && jsonDecode(response.body)['status'] == true) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }

  Future<InvoiceModel> getInvoice(String idUser, String orderCode) async{
    try{
      final response = await http.post(baseUrl + "getInvoice", body:{
        'iduser' : idUser,
        'ordercode' : orderCode,
      });
      if( response.statusCode == 200 && jsonDecode(response.body)["status"]==200 ){
        InvoiceModel invoiceModel = InvoiceModel.fromJson(jsonDecode(response.body));
        return invoiceModel;
      }else{
        return null;
      }
    }catch(e){
      print("Exception: $e");
    }
  }

  Future getProduct() async {
    try {
      final response = await http.get(baseUrl + "getProduk");
      if (response.statusCode == 200 &&
          productModelFromJson(response.body).status == 200) {
        return productModelFromJson(response.body).dataProduct;
      } else {
        return null;
      }
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }

  Future getProdCategory(idCategory) async {
    try {
      final response = await http
          .post(baseUrl + "produkPerKategori", body: {'id': "$idCategory"});
      if (response.statusCode == 200 &&
          productModelFromJson(response.body).status == 200) {
        return productModelFromJson(response.body).dataProduct;
      } else {
        return null;
      }
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }
}

final networkRepo = NetworkRepo();
