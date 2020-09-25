import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SingleMarkerMap extends StatefulWidget {
  final LatLng coordinate;
  const SingleMarkerMap({Key key, @required this.coordinate}) : super(key: key);
  @override
  _SingleMarkerMapState createState() => _SingleMarkerMapState();
}

class _SingleMarkerMapState extends State<SingleMarkerMap> {

  List<Marker> _marker = List<Marker>();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    setState(() {
      _marker.add(
          Marker(
              markerId: MarkerId("mark1"),
              position: widget.coordinate
          )
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.coordinate,
        zoom: 14,
      ),
      markers: _marker.toSet(),
      polylines: Set<Polyline>.of(polylines.values),
    );
  }

}
