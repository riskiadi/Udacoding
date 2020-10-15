import 'dart:convert';

import 'package:beritaku/model/newsmodel.dart';
import 'package:beritaku/ui/screens/edit.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:recase/recase.dart';

class DetailPage extends StatefulWidget {

  final NewsModel newsModel;

  DetailPage({@required this.newsModel});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
              onPressed: (){
                deleteNews(widget.newsModel.newsId);
              }
          ),
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){
                Get.to(EditPage(
                  newsId: widget.newsModel.newsId,
                  title: widget.newsModel.newsTitle,
                  content: widget.newsModel.newsContent,
                  newsCategory: widget.newsModel.newsCategory.categoryName,
                  imageBanner: widget.newsModel.newsBanner,
                ));
              }
          ),
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
                height: MediaQuery.of(context).size.height/2.5,
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/avatar.svg', width: 40, height: 40,),
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
                    width: MediaQuery.of(context).size.width/4,
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
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500
                  ),
                )
            ),

            Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 15),
                child: Text(
                  widget.newsModel.newsContent,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.8)),
                )
            ),

          ],
        ),
      ),
    );
  }
  
  deleteNews(int newsId) async{
    dio.Dio dioNetwork = dio.Dio();
    dioNetwork.options.baseUrl = 'https://flutterest.000webhostapp.com/nagari/Api/addNews';
    dioNetwork.options.contentType = 'application/form-data';
    dio.Response response = await dioNetwork.post('https://flutterest.000webhostapp.com/nagari/Api/deleteNews', data: {"news_id" : newsId});
    print(response.data.toString());
  }
  

}
