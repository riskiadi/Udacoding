import 'dart:convert';
import 'dart:io';

import 'package:beritaku/model/newsmodel.dart';
import 'package:beritaku/ui/screens/edit.dart';
import 'package:beritaku/ui/screens/home.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:recase/recase.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  final NewsModel newsModel;

  DetailPage({@required this.newsModel});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    print(widget.newsModel.newsId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                EasyLoading.show();
                deleteNews(widget.newsModel.newsId).then((_){
                  EasyLoading.dismiss();
                  Get.back(result: true);
                });
              }),
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Get.to(EditPage(
                  newsId: widget.newsModel.newsId,
                  title: widget.newsModel.newsTitle,
                  content: widget.newsModel.newsContent,
                  newsCategory: widget.newsModel.newsCategory.categoryName,
                  imageBanner: widget.newsModel.newsBanner,
                )).then((value){
                  if(value??false){
                    sendNotification('1 berita telah diubah');
                    Get.offAll(HomePage());
                  }
                });
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.newsModel.newsId,
              child: Image.network(
                widget.newsModel.newsBanner,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 10, right: 10, top: 15, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/avatar.svg',
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'By ${widget.newsModel.newsAuthor.authorName.titleCase}',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 3),
                          Text(widget.newsModel.newsAuthor.authorEmail),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 3,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  widget.newsModel.newsTitle,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                )),
            Container(
                margin: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 20, top: 15),
                child: Text(
                  widget.newsModel.newsContent,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 16, color: Colors.black.withOpacity(0.8)),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> deleteNews(int newsId) async {
    Map<String, dynamic> dataPost = {"news_id": newsId};
    final dioNetwork = dio.Dio(
        dio.BaseOptions(contentType: "application/x-www-form-urlencoded"));
    dio.Response resp = await dioNetwork.post(
        "https://flutterest.000webhostapp.com/nagari/Api/deleteNews",
        data: dataPost);
    print(resp.data.toString());
  }

  sendNotification(String content) async {
    final dioNetwork = dio.Dio();
    dioNetwork.options.headers = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAAWKZPac8:APA91bEZuPi9ZsYT7uQtXEQVpdTMSAfsEZVkZiXJ4i_yM6mxBeGD12i6oM-hWZvN01MsiInMpyFUiVbJCUJWPAKjagyev4sdw6mBAGe0LU0Yr4y2jAZ6ulc_xaXkaveBx5MEdqQdDPUK",
    };
    var dataPost = {
      "to": "/topics/beritaku",
      "topic": "beritaku",
      "notification": {
        "title": "Breaking News",
        "body": "New news available.",
        "sound": "default"
      },
      "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "content": content}
    };
    dio.Response cc = await dioNetwork.post(
        'https://fcm.googleapis.com/fcm/send',
        data: jsonEncode(dataPost));
    debugPrint(cc.data.toString());
  }
}
