import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:random_color/random_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_app/models/content_model.dart';
import 'package:wisata_app/repository.dart';
import 'package:wisata_app/ui/add.dart';
import 'package:wisata_app/ui/detail.dart';
import 'package:wisata_app/ui/mainmap.dart';
import 'package:wisata_app/widgets/home_banner.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String name;
  String email;
  String photoURI;

  final _randomColor = RandomColor();

  List<ContentModel> listDestination = List<ContentModel>();
  List<LatLng> markers = List<LatLng>();

  @override
  void initState() {

    _getData().then((value){
      name = value.getString("name");
      email = value.getString("email");
      photoURI = value.getString("photo");
      setState(() {});
    });

    ContentRepository().databaseReference().then((DatabaseReference ref){
      ref.onChildAdded.listen((event) {
        _getContent();
      });
      ref.onChildRemoved.listen((event) {
        _getContent();
      });
      ref.onChildChanged.listen((event) {
        _getContent();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFF5F8FE),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "mapPage",
              child: Icon(Icons.map),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainMap(markers: markers, detailContent: listDestination,),));
              },
            ),
            SizedBox(height: 17),
            FloatingActionButton(
              heroTag: "addPage",
              child: Icon(Icons.add),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage(),));
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            HomeBanner(size: size, nama: name??"", photoURI: photoURI, email: email),
            SizedBox(height: 20,),

            listDestination.length>0 ? Container() : Column(children: [CircularProgressIndicator(), SizedBox(height: 10), Text("Loading..."),],),

            ListView.builder(
              itemCount: listDestination.length,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return contentList(content: listDestination[index]) ;
              },
            ),

            SizedBox(height: 20,),


          ],
        ),
      ),
    );
  }

  ListTile contentList({@required ContentModel content}) {
    return ListTile(
            leading: ClipOval(
              child: Container(
                width: 50,
                height: 50,
                color: _randomColor.randomColor(colorHue: ColorHue.blue,  colorBrightness: ColorBrightness.veryLight),
                child: Center(
                    child: Text(
                      content.locationName[0],
                      style: TextStyle(fontSize: 19),
                    )
                ),
              ),
            ),
            title: Text(content.locationName),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            subtitle: Text(
              content.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(contentModel: content,),));
            },
          );
  }

 Future<void> _getContent() async{
   DataSnapshot snapshot = await ContentRepository().getContent();
    setState(() {
      listDestination.clear();
      markers.clear();
      var keys = snapshot.value.keys;
      for(var key in keys){
        listDestination.add(
            ContentModel(
              firebaseKey: key,
              locationName: snapshot.value[key]['location_name'],
              description: snapshot.value[key]['description'],
              address: snapshot.value[key]['address'],
              images: snapshot.value[key]['images'],
              latitude: snapshot.value[key]['latitude'],
              longitude: snapshot.value[key]['longitude'],
            ));
        markers.add(LatLng(snapshot.value[key]['latitude'], snapshot.value[key]['longitude']));
      }
    });
  }

  Future<SharedPreferences> _getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }


}
