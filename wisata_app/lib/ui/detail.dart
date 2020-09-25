import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wisata_app/models/content_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wisata_app/ui/edit.dart';
import 'package:wisata_app/ui/singlemap.dart';

class DetailPage extends StatefulWidget {

  final ContentModel contentModel;

  const DetailPage({Key key, @required this.contentModel}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  ContentModel _contentModel = ContentModel();

  @override
  void initState() {
    _contentModel = widget.contentModel;
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
          IconButton(icon: Icon(Icons.edit),onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(contentModel: widget.contentModel,),));
          },),
          IconButton(icon: Icon(Icons.delete),onPressed: (){
            removeData(_contentModel.firebaseKey).then((value){
              Navigator.pop(context);
            });
          },),
        ],
      ),
      body: Stack(
        children: [

          Positioned(
            left: MediaQuery.of(context).size.width/2-20,
            top: MediaQuery.of(context).size.height*0.2,
            child: CircularProgressIndicator(),
          ),

          CarouselSlider(
            options: CarouselOptions(
                height: MediaQuery.of(context).size.height*0.50,
                autoPlay: true,
                viewportFraction: 1,
                autoPlayInterval: Duration(seconds: 2),
            ),
            items: _contentModel.images.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                  child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: i, fit: BoxFit.cover,),
                  );
                },
              );
            }).toList(),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.15,
            child: Text("s"),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ]
              )
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.7,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
              ),
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      _contentModel.locationName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600
                      ),
                    ),

                    SizedBox(height: 10,),

                    Text(
                      "Description",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(_contentModel.description),

                    SizedBox(height: 10,),

                    Text(
                      "Address",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(_contentModel.address),

                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 0.5,
            right: 0.5,
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RaisedButton(
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, color: Colors.white.withOpacity(0.8),),
                    SizedBox(width: 10),
                    Text("View On Google Map", style: TextStyle(color: Colors.white.withOpacity(0.8)),),
                  ],
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SingleMarkerMap(coordinate: LatLng(_contentModel.latitude, _contentModel.longitude),),));
                },
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future<void> removeData(String key){
    FirebaseDatabase _firebase = FirebaseDatabase.instance;
    DatabaseReference _ref = _firebase.reference();
    return _ref.child(key).remove();
  }

}
