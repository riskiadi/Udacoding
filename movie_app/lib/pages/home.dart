import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/favorite_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/favorite_detail.dart';
import 'package:movie_app/pages/login.dart';
import 'package:movie_app/pages/movie_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Menu{
  home, favorites
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var menuState = Menu.home;
  var title = "Home";
  var name = '-';

  SharedPreferences sharedPref;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value){
      sharedPref = value;
      name = value.get('sName');
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF5F8FC),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(titleChange(menuState)),
      ),
      drawer: drawerWidget(context),
      body: menuContent(),
    );
  }

  Widget homeContent(){
    return Container(
      child: FutureBuilder(
        future: getMovieData(),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ? homeVideoList(snapshot.data) : Center(child: CircularProgressIndicator(strokeWidth: 2,),);
        },
      ),
    );
  }

  Widget favoritesContent(){
    return Container(
      child: FutureBuilder(
        future: getFavoriteData(),
        builder: (context, snapshot) {
          if(snapshot.hasError)print(snapshot.error);
          return snapshot.hasData ? favoriteVideoList(snapshot.data) : Center(child: CircularProgressIndicator(strokeWidth: 2,),);
        },
      ),
    );
  }

  Widget menuContent(){
    switch(menuState){
      case Menu.favorites: {
        return favoritesContent();
      }break;
      default:{
        return homeContent();
      }break;
    }
  }

  ////////////////////////

  Widget drawerWidget(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
              Container(
                width: double.infinity,
                color: Colors.red,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: 60, color: Colors.white,),
                    Text(name, style: TextStyle(color: Colors.white, fontSize: 17),)
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
                title: Text('Favorites'),
                leading: Icon(Icons.favorite),
                onTap: () {
                  menuState = Menu.favorites;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              Divider(),
              ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  var sharedPreference = SharedPreferences.getInstance();
                  sharedPreference.then((value){
                    value.clear();
                    setState(() {});
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage(),), (route) => false);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeVideoList(MovieModel dataList){
    return ListView.builder(
      itemCount: dataList.movies.length==null ? 0 : dataList.movies.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 10,
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Container(
                height: 200,
                child: GestureDetector(
                  child: Hero(tag: 'thumbnail-$index', child: Image.network(dataList.movies[index].thumbnail, fit: BoxFit.cover, width: 1000,)),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(data: dataList.movies[index], index: index, userId: sharedPref.get('sID'),),));
                    },
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 10, right: 8, left: 8),
                child: Text(
                  dataList.movies[index].movieName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 10, right: 8, left: 8, bottom: 15),
                child: Text(
                  dataList.movies[index].description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget favoriteVideoList(FavoriteModel dataList){
    return ListView.builder(
      itemCount: dataList.favorites==null ? 0 : dataList.favorites.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 10,
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Container(
                height: 200,
                child: GestureDetector(
                  child: Hero(tag: 'thumbnail-$index', child: Image.network(dataList.favorites[index].thumbnail, fit: BoxFit.cover, width: 1000,)),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavoriteDetailPage(data: dataList.favorites[index], index: index, userId: sharedPref.get('sID'),),));
                  },
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 10, right: 8, left: 8),
                child: Text(
                  dataList.favorites[index].movieName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 10, right: 8, left: 8, bottom: 15),
                child: Text(
                  dataList.favorites[index].description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String titleChange(menuState){
    switch(menuState){
      case Menu.favorites: {
        return 'My Favorites';
      }break;
      default:{
        return 'Home';
      }break;
    }
  }

  Future<MovieModel> getMovieData() async{
    var response = await http.get('http://alkalynxt.000webhostapp.com/udacoding_movie/gets/');
    if(response.statusCode == 200){
      return movieModelFromJson(response.body);
    }else{
      return MovieModel();
    }
  }

  Future<FavoriteModel> getFavoriteData() async{
    var response = await http.post('http://alkalynxt.000webhostapp.com/udacoding_movie/gets/favorites/', body: {"userID":"${sharedPref.get('sID')}"});
    if(response.statusCode == 200){
      return favoriteModelFromJson(response.body);
    }else{
      return FavoriteModel();
    }
  }

}