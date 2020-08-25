import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:online_note/models/note_post.dart';
import 'package:online_note/models/note_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/note_get.dart';
import 'package:http/http.dart' as http;

class Services {

  //Fetch Data
  Future<NoteGet> fetchNote() async {
    var sharedPreference = await SharedPreferences.getInstance();
    var id = await sharedPreference.get("sID");
    try {
      final response = await http.post(
          "https://alkalynxt.000webhostapp.com/udacoding_note/gets/",
          body: {"account_id": "$id"});
      if (response.statusCode == 200) {
        return noteGetFromJson(utf8.decode(response.bodyBytes));
      } else {
        return NoteGet();
      }
    } catch (e) {
      return NoteGet();
    }
  }

  //Post Data
  Future<NotePost> postNote({@required String title, @required String note}) async {
    var sharedPreference = await SharedPreferences.getInstance();
    var _id = await sharedPreference.get("sID");
    try {
      var response = await http.post(
        "https://alkalynxt.000webhostapp.com/udacoding_note/add/",
        body: {
          'account_id': _id,
          'title': title,
          'note': note,
        },
      );
      if (response.statusCode == 200) {
        return notePostFromJson(utf8.decode(response.bodyBytes));
      } else {
        return NotePost();
      }
    } catch (e) {
      print(e);
      return NotePost();
    }
  }

  //Update Note
  Future<NoteUpdate> updateNote({@required String accountId, @required String noteId, @required String title, @required String note}) async {
    try{
      var url = "https://alkalynxt.000webhostapp.com/udacoding_note/update/";
      var body = {
        "account_id" : accountId,
        "note_id" : noteId,
        "title" : title,
        "note" : note,
      };
      var response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        return noteUpdateFromJson(response.body);
      } else {
        return NoteUpdate();
      }
    }catch(e){
      print(e);
      return NoteUpdate();
    }
  }

  //Delete Note
  Future<NoteUpdate> deleteNote({@required String accountId, @required String noteId}) async {
    try{
      var url = "https://alkalynxt.000webhostapp.com/udacoding_note/delete/";
      var body = {
        "account_id" : accountId,
        "note_id" : noteId,
      };
      var response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        return noteUpdateFromJson(response.body);
      } else {
        return NoteUpdate();
      }
    }catch(e){
      print(e);
      return NoteUpdate();
    }
  }

}