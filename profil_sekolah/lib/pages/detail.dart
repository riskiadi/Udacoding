import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:profil_sekolah/pages/alter.dart';

class DetailPage extends StatefulWidget {

  final String firebaseKey;
  final double latitude;
  final double longitude;
  final String title;
  final String description;

  const DetailPage({Key key, this.firebaseKey, this.latitude, this.longitude, this.title, this.description}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            child: Row(
              children: [
                Icon(Icons.edit, color: Colors.white,),
                SizedBox(width: 10,),
                Text(
                  'EDIT',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AlterPage(
                firebaseKey: widget.firebaseKey,
                namaSekolah: widget.title,
                deskripsi: widget.description,
                latitude: widget.latitude,
                longitude: widget.longitude,
              ),));
            },
          ),
        ],
      ),
      body: ListView(
        children: [

          SizedBox(
            height: 300,
            width: 300,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.latitude, widget.longitude),
                  zoom: 17
              ),
              markers: <Marker>[
                Marker(
                  markerId: MarkerId('position'),
                  position: LatLng(widget.latitude, widget.longitude),
                ),
              ].toSet(),
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                Factory<OneSequenceGestureRecognizer>(()=>ScaleGestureRecognizer()),
              ].toSet(),
            ),
          ),

          Container(
            padding: const EdgeInsets.only(left: 17, right: 17, top: 17),
            child: Text(widget.title, style: TextStyle(fontSize: 20),),
          ),

          Container(
            padding: const EdgeInsets.only(left: 17, right: 17, top: 17),
            child: Text(widget.description, style: TextStyle(fontSize: 16),),
          ),

          Container(
            padding: const EdgeInsets.only(left: 17, right: 17, top: 17),
            child: Text("Latitude: ${widget.latitude.toString()}", style: TextStyle(fontSize: 16),),
          ),

          Container(
            padding: const EdgeInsets.only(left: 17, right: 17, top: 5),
            child: Text("Longitude: ${widget.longitude.toString()}", style: TextStyle(fontSize: 16),),
          ),

        ],
      ),
    );
  }
}
