import 'dart:convert';

import 'package:aplikasi_berita/api.dart';
import 'package:aplikasi_berita/models/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';

class DetailPage extends StatefulWidget {

  final PostModel post;

  const DetailPage({Key key, @required this.post}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News ${widget.post.idNews}"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              setState(() {
                _isLoading = true;
              });
              Api().deleteNews(widget.post.idNews).then((Response response){
                var result = jsonDecode(response.body);
                _alertDialog(result['message']);
                setState(() {
                  _isLoading = false;
                });
              });
            },
          ),
        ],
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(height: 10),
              Text(widget.post.titleNews, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(height: 20),
              Text(widget.post.contentNews, style: TextStyle(fontSize: 18),),
            ],
          ),
        ),
      ),
    );
  }

  _alertDialog(String message){
    var alertDialog = AlertDialog(
      title: Text('Delete'),
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
