import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/watch.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatefulWidget {
  final Movie data;
  final int index;
  final String userId;
  DetailPage({Key key, @required this.data, @required this.index, @required this.userId}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences sharedPreferences;
  bool isLike=false;
  bool isLoading = true;

  @override
  void initState() {
    isFavorite().then((value){
      isLike=value;
      isLoading = false;
      if(value==true)showSnackBar('This is your favorite movie.');
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.data.movieName),
      ),
      floatingActionButton: isLoading? Container() : FloatingActionButton(
        child: Icon(isLike? Icons.favorite : Icons.favorite_border, size: 30,),
        onPressed: (){
          likeMethod();
        },
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: ListView(
          children: [
            Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Hero(
                        tag: 'thumbnail-${widget.index}',
                        child: Image.network(
                          widget.data.thumbnail,
                          height: 230,
                          fit: BoxFit.cover,
                          color: Colors.black.withOpacity(0.5),
                          colorBlendMode: BlendMode.darken,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(60),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(60),
                              child: Icon(Icons.play_circle_filled, color: Colors.white, size: 110,),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WatchPage(url: widget.data.link,),));
                              },
                            )
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5),blurRadius: 30, offset: Offset(0.0, -70.0), spreadRadius: 10)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      widget.data.movieName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Description:',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.data.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  likeMethod(){
    setFavorite().then((value){
      if(value=='added'){
        isLike = true;
        showSnackBar('Added to Favorite');
        setState(() {});
      }else if(value=='removed'){
        isLike = false;
        showSnackBar('Removed From Favorite');
        setState(() {});
      }
    });
  }

  showSnackBar(String text){
    var snackbar = SnackBar(content: Text(text));
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Future<bool> isFavorite()async{
    var response = await http.post('http://alkalynxt.000webhostapp.com/udacoding_movie/gets/favorite/', body: {"userID":"${widget.userId}", "movieID": "${widget.data.id}"});
    if(response.statusCode==200){
      return jsonDecode(response.body)['isFavorite'];
    }else{
      return false;
    }
  }

  Future<String> setFavorite()async{
    var response = await http.post('http://alkalynxt.000webhostapp.com/udacoding_movie/setfavorite/', body: {"userID":"${widget.userId}", "movieID": "${widget.data.id}"});
    if(response.statusCode==200){
      return jsonDecode(response.body)['status'];
    }else{
      return '';
    }
  }

}
