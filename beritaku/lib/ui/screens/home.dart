import 'dart:convert';
import 'dart:io';

import 'package:beritaku/model/infomodel.dart';
import 'package:beritaku/model/newsmodel.dart';
import 'package:beritaku/ui/screens/addnews.dart';
import 'package:beritaku/ui/screens/profile.dart';
import 'package:beritaku/ui/widgets/alert_dialog.dart';
import 'package:beritaku/ui/widgets/news_list.dart';
import 'package:beritaku/ui/widgets/news_toprated.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final getStorage = GetStorage();
  int curentTabIndex = 0;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    _firebaseMessaging.subscribeToTopic('beritaku');
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async{
        return showDialog(
          context: context,
          builder: (context) => MyAlertDialog(title: 'Notification', content: message['data']['content'],),
        );
      },

      onLaunch: (message) {return null;},
      onResume: (message) {return null;},
    );

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beritaku"),
        actions: [
          IconButton(
              icon: SvgPicture.asset('assets/images/avatar.svg', width: 30,),
              onPressed: (){
                Get.to(ProfilePage());
              }
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.add),
        onPressed: (){
          Get.to(AddNewsPage()).then((value){
            if(value??false){
              setState(() {
                sendNotification("1 berita baru ditambahkan.");
              });
            }
          });
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder(
              future: getInfoNews(),
              builder: (context, AsyncSnapshot<InfoModel> snapshot) {
                if(snapshot.hasData){
                  return NewsTopRated(snapshot.data.categories);
                }else{
                  return Center(
                    child: Container(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                'News List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder(
              future: getNews(),
              builder: (context, AsyncSnapshot<List<NewsModel>> snapshot) {
                if(snapshot.hasData){
                  return NewsList(
                    news: snapshot.data,
                    isRefresh: (bool refresh) {
                      if(refresh??false){
                        setState(() {
                          sendNotification("1 Berita dihapus");
                        });
                      }
                    },
                  );
                }else{
                  return Center(
                    child: Container(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            )
          ],
        ),
      )
    );
  }

  Future<List<NewsModel>> getNews() async{
    http.Response response = await http.get('https://flutterest.000webhostapp.com/nagari/Api/getNews');
    return newsModelFromJson(response.body);
  }

  Future<InfoModel> getInfoNews() async{
    http.Response response = await http.get('https://flutterest.000webhostapp.com/nagari/Api/getNewsInfo');
    return infoModelFromJson(response.body);
  }

  sendNotification(String content) async {
    final dioNetwork = dio.Dio();
    dioNetwork.options.headers = {
      "Content-Type": "application/json",
      "Authorization": "key=AAAAWKZPac8:APA91bEZuPi9ZsYT7uQtXEQVpdTMSAfsEZVkZiXJ4i_yM6mxBeGD12i6oM-hWZvN01MsiInMpyFUiVbJCUJWPAKjagyev4sdw6mBAGe0LU0Yr4y2jAZ6ulc_xaXkaveBx5MEdqQdDPUK",
    };
    var dataPost = {
      "to": "/topics/beritaku",
      "topic": "beritaku",
      "notification": {
        "title": "Breaking News",
        "body": "New news available.",
        "sound": "default"
      },
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "content": content
      }
    };
    dio.Response cc = await dioNetwork.post('https://fcm.googleapis.com/fcm/send', data: jsonEncode(dataPost));
    debugPrint(cc.data.toString());
  }


}