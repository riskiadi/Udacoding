import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:wisata_app/models/content_model.dart';
import 'package:wisata_app/ui/home.dart';
import 'package:wisata_app/ui/detail.dart';

class MainMap extends StatefulWidget {

  final List<LatLng> markers;
  final List<ContentModel> detailContent;

  const MainMap({Key key, @required this.markers, @required this.detailContent}) : super(key: key);

  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {

  List<LatLng> _mapMarkers= List<LatLng>();
  List<Marker> _markers = List<Marker>();

  bool _sheetAlwaysShow = false;

  GoogleMapController _googleMapController;
  int markersIndex=0;

  @override
  void initState() {
    int counter = 0;
    setState(() {
      _mapMarkers = widget.markers;
      widget.markers.forEach((LatLng element) {
        _markers.add(Marker(
            markerId: MarkerId(counter.toString()),
            position: element,
          infoWindow: InfoWindow(title: widget.detailContent[counter].locationName,),
        ));
        counter++;
      });


    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomSheet: SolidBottomSheet(
        showOnAppear: _sheetAlwaysShow,
        autoSwiped: true,
        maxHeight: MediaQuery.of(context).size.height*0.34,
        headerBar: Container(
          height: 40,
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Text('Location Info', style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.7)),),
          ),
        ),
        body: bottomSheetBody(),
      ),

      body: Stack(
        children: [

          GoogleMap(
            markers: _markers.toSet(),
            initialCameraPosition: CameraPosition(
                target: _mapMarkers.first,
                zoom: 10
            ),
            onMapCreated: (controller) {
              _googleMapController = controller;
            },
          ),


          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    mini: true,
                    heroTag: "navigate_left",
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: Icon(Icons.chevron_left,size: 30,),
                    onPressed: (){
                      if(markersIndex>0){
                        setState(() {
                          markersIndex--;
                          _googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                              target: _mapMarkers[markersIndex],
                              zoom: 12,
                          )));
                          _sheetAlwaysShow = true;
                        });
                      }
                    },
                  ),
                  FloatingActionButton(
                    mini: true,
                    heroTag: "navigate_right",
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: Icon(Icons.chevron_right,size: 30,),
                    onPressed: (){
                      if(markersIndex<_mapMarkers.length-1){
                        setState(() {
                          markersIndex++;
                          _googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                              target: _mapMarkers[markersIndex],
                              zoom: 12,
                          )));
                          _sheetAlwaysShow = true;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  Container bottomSheetBody() {
    return Container(
      padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "Destination Name",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              Text(
                widget.detailContent[markersIndex].locationName,
                style: TextStyle(fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 13),

              Text(
                "Address",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              Text(
                widget.detailContent[markersIndex].address,
                style: TextStyle(fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 13),

              Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.public),
                      SizedBox(width: 8),
                      Text("Detail", style: TextStyle(letterSpacing: 2),),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(contentModel: widget.detailContent[markersIndex]),));
                  },
                )),
          ],
          ),
        ),
      );
  }

}
