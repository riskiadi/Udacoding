import 'dart:convert';
import 'dart:io';

import 'package:aplikasi_berita/constant.dart';
import 'package:http/http.dart' as http;
class Api{

  static const String URL = "https://alkalynxt.000webhostapp.com/news/index.php/Api";
  static const String REGISTER = "/registerUser";
  static const String LOGIN = "/loginUser";
  static const String GET_NEWS = "/getNews";
  static const String ADD_NEWS = "/addNews";
  static const String DELETE_NEWS = "/deleteNews";

  Future<http.Response> loginUser(String email, String password){
    Map<String, dynamic> body = {
      'email' : email,
      'password' : password,
    };
    return http.post(URL+LOGIN, body: body);
  }

  Future<http.Response> registerUser(String name, String email, String password){
    Map<String, dynamic> body = {
      'fullName' : name,
      'email' : email,
      'password' : password,
    };
    return http.post(URL+REGISTER, body: body);
  }

  Future<http.Response> addNews(String title, String content){
    Map<String, dynamic> body = {
      'title' : title,
      'content' : content,
    };
    return http.post(URL+ADD_NEWS, body: body);
  }
  
  Future<http.Response> deleteNews(String newsId){
    return http.post(URL+DELETE_NEWS, body: {'news_id':newsId});
  }

  Future<http.Response> getNews(){
    return http.get(URL+GET_NEWS);
  }

  Future<http.Response> sendNotif(String newsTitle, String content) async {
    String body = jsonEncode({
      "to": "/topics/newsNotification",
      "notification": {
        "title": "Breaking News",
        "body": "New news available."
      },
      "data": {
        "title": newsTitle,
        "content": content
      }
    });

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader : "application/json",
      HttpHeaders.authorizationHeader : serverKey
    };

    return await http.post(baseUrl, body: body, headers: header);
  }

}