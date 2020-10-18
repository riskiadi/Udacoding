import 'dart:convert';

import 'package:beritaku/model/newsmodel.dart';
import 'package:beritaku/ui/widgets/news_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recase/recase.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

class CategoryPage extends StatefulWidget {

  final String category;
  const CategoryPage({Key key, @required this.category}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.titleCase),),
      body: FutureBuilder(
        future: getNews(),
        builder: (context, AsyncSnapshot<List<NewsModel>> snapshot) {
          if(snapshot.hasData){
            return NewsList(
              news: filterContent(widget.category, snapshot.data),
              isRefresh: (bool refresh){
                if(refresh==true){
                  setState(() {
                    sendNotification('1 Berita dihapus');
                    Get.back(result: true);
                  });
                }
              },
            );
          }else{
            return Center(child: Container(child: CircularProgressIndicator(),));
          }
        },
      ),
    );
  }

  List<NewsModel> filterContent(String filterCategory, List<NewsModel> newsList){
    List<NewsModel> filtered = newsList.where((element){
      var filter = element.newsCategory.categoryName.toLowerCase();
      return (filter.contains(filterCategory.toLowerCase()));
    }).toList();
    return filtered;
  }

  Future<List<NewsModel>> getNews() async{
    http.Response response = await http.get('https://flutterest.000webhostapp.com/nagari/Api/getNews');
    return newsModelFromJson(response.body);
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
