import 'dart:convert';

import 'package:beritaku/model/infomodel.dart';
import 'package:beritaku/model/newsmodel.dart';
import 'package:beritaku/ui/screens/addnews.dart';
import 'package:beritaku/ui/screens/profile.dart';
import 'package:beritaku/ui/widgets/news_list.dart';
import 'package:beritaku/ui/widgets/news_toprated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final getStorage = GetStorage();
  int curentTabIndex = 0;
  // Future<List<NewsModel>> _newsList;

  @override
  void initState() {
    // xx = getNews();
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
            if(value) setState(() {

            });
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
                  return NewsTopRated(snapshot.data.categories, getNews());
                }else{
                  return Container();
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
                return NewsList(snapshot.data);
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

}