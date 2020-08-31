import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:youtube_playlist/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_playlist/models/music_model.dart';
import 'package:youtube_playlist/pages/watch.dart';

enum Menu{
  home, movie, music
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var menuState = Menu.home;
  var title = "Home";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(titleChange(menuState)),
      ),
      drawer: drawerWidget(context),
      body: menuContent(),
    );
  }

  Widget homeContent(){
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset('assets/images/home.png', height: 120, fit: BoxFit.cover,),
            SizedBox(height: 60,),
          Text('Explore My Youtube Playlist', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w300, color: Colors.white),),
            SizedBox(height: 60,),
          ],
        ),
      ),
    );
  }

  Widget movieContent(){
    return Container(
      child: FutureBuilder(
        future: getMovieData(),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ? videoList(snapshot.data) : Center(child: CircularProgressIndicator(strokeWidth: 2,),);
        },
      ),
    );
  }

  Widget musicContent(){
    return Container(
      child: FutureBuilder(
        future: getMusicData(),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ? videoList(snapshot.data) : Center(child: CircularProgressIndicator(strokeWidth: 2,),);
        },
      ),
    );
  }

  Widget menuContent(){
    switch(menuState){
      case Menu.movie: {
        return movieContent();
      }break;
      case Menu.music: {
        return musicContent();
      }break;
      default:{
        return homeContent();
      }break;
    }
  }



  Widget drawerWidget(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
              Container(
                width: double.infinity,
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/youtube.png', height: 60, fit: BoxFit.cover,),
                    SizedBox(height: 10,),
                    Text('Youtube.com', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),)
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home),
                onTap: (){
                  menuState = Menu.home;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              Divider(),
              ListTile(
                title: Text('Movie Playlist'),
                leading: Icon(Icons.movie),
                onTap: () {
                  menuState = Menu.movie;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              Divider(),
              ListTile(
                title: Text('Music Playlist'),
                leading: Icon(Icons.library_music),
                onTap: () {
                  menuState = Menu.music;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget videoList(var dataList){
    return ListView.builder(
      itemCount: dataList.length==null ? 0 : dataList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WatchPage(url: 'https://youtube.com/embed/${dataList[index].contentDetails.videoId}',),));
                  },
                  child: Image.network(
                      dataList[index].snippet.thumbnails.high.url,
                  ),
                ),
              ),
              Row(
                children: [
                  Flexible(
                      child: Text(
                        dataList[index].snippet.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                ],
              ),
              Divider(thickness: 2, height: 10, color: Colors.white30,),
            ],
          ),
        );
      },
    );
  }

  String titleChange(menuState){
    switch(menuState){
      case Menu.movie: {
        return 'Movie Playlist';
      }break;
      case Menu.music: {
        return 'Music Playlist';
      }break;
      default:{
        return 'Home';
      }break;
    }
  }

  Future<List<MovieModel>> getMovieData() async{
    var response = await http.get('https://fluttertube.herokuapp.com/');
    if(response.statusCode == 200){
      return movieModelFromJson(response.body);
    }else{
      return List<MovieModel>();
    }
  }

  Future<List<MusicModel>> getMusicData() async{
    var response = await http.get('https://fluttertube2.herokuapp.com/');
    if(response.statusCode == 200){
      return musicModelFromJson(response.body);
    }else{
      return List<MusicModel>();
    }
  }

}
