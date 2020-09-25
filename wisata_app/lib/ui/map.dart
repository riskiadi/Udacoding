import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  List<Marker> _markers = List<Marker>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(-6.1753924,106.8249587),
                zoom: 10,
            ),
            onTap: _handleTap,
            markers: _markers.toSet(),
          ),

          Positioned(
            top: 40,
            left: 0.5,
            right: 0.5,
            child: _markers.length<=0? Container() : FloatingActionButton(child: Icon(Icons.check), onPressed:() => Navigator.pop(context, _markers.first.position),)
          ),

        ],
      ),

    );
  }


  void _handleTap(LatLng position) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(position.toString()),
        position: position,
      ));
    });
  }

}
