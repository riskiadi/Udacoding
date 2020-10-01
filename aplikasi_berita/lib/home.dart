import 'dart:convert';

import 'package:aplikasi_berita/account.dart';
import 'package:aplikasi_berita/add.dart';
import 'package:aplikasi_berita/api.dart';
import 'package:aplikasi_berita/detail.dart';
import 'package:aplikasi_berita/models/post.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String name="";
  String email="";
  bool _isLoading = false;

  Future<List<PostModel>> newsList;

  @override
  void initState() {
    _getUserData();
    _getNotifikasi();
    super.initState();
    newsList = _getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple News App'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage(name: name,email: email,),));
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage(),)).then((value){
            if(value!=null){
              if(value){
                setState(() {
                  newsList = _getNews();
                });
              }
            }
          });

        },
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<PostModel>>(
                future: newsList,
                builder: (context, snapshot) {
                  List<PostModel> data = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: data==null ? 0 : data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(data[index].titleNews[0].toUpperCase()),
                        ),
                        title: Text(data[index].titleNews, maxLines: 2, overflow: TextOverflow.ellipsis,),
                        subtitle: Text(data[index].contentNews, maxLines: 2, overflow: TextOverflow.ellipsis,),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(post: data[index],),)).then((value){
                            if(value!=null){
                              if(value){
                                setState(() {
                                  newsList = _getNews();
                                });
                              }
                            }
                          });
                        },
                        isThreeLine: true,
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences.getString('name');
    email = sharedPreferences.getString('email');
    setState(() {});
  }

  Future<List<PostModel>> _getNews() async {
    setState(() {
      _isLoading = true;
    });
    Response response = await Api().getNews();
    setState(() {
      _isLoading = false;
    });
    if(response.statusCode == 200){
      return postModelFromJson(response.body);
    }else{
      throw "failed load to internet";
    }
  }

  _getNotifikasi(){
    _firebaseMessaging.subscribeToTopic('newsNotification');
    _firebaseMessaging.configure(
      //Ketika dalam aplikasi
      onMessage: (Map<String, dynamic> message) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(message['data']['title']),
              content: Text(message['data']['content']),
              actions: [
                FlatButton(child: Text('Ok'), onPressed: () {
                  Navigator.pop(context);
                }),
              ],
            );
          },
        );
      },

      //Ketika keadaan app tertutup
      onLaunch: (Map<String, dynamic> message) {

      },

      //Ketika app berjalan di background
      onResume: (Map<String, dynamic> message) {

      },
    );
  }

  _alertDialog(String message){
    var alertDialog = AlertDialog(
      title: Text('Add'),
      content: Text(message),
      actions: [
        FlatButton(child: Text('Ok'), onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context, true);
        }),
      ],
    );
    return showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }

}
