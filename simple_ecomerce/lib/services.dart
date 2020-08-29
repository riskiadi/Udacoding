import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'models/fetch_all.dart';

class Services {

  static const url = "http://alkalynxt.000webhostapp.com/udacoding_ecomerce";

  //Fetch Data
  Future<FetchAll> fetchNote() async {
    try {
      final response = await http.get("$url/gets/");
      if (response.statusCode == 200) {
        return fetchAllFromJson(utf8.decode(response.bodyBytes));
      } else {
        return FetchAll();
      }
    } catch (e) {
      return FetchAll();
    }
  }

}