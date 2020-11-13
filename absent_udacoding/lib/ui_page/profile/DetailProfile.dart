import 'dart:async';
import 'package:absent_udacoding/model/ModelAbsent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailProfile extends StatefulWidget {
  Absent data;
  DetailProfile({this.data});

  @override
  _DetailProfileState createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {

  LatLng myLocation;
  Timer _timer;
  Completer<GoogleMapController> _controller = Completer();
  final Map<String, Marker> _marker = {};

  Future changeCameraPosition(CameraPosition camLocation) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(camLocation));
  }

  void getCurrentLocation() async {
    var currentLocation = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _marker.clear();
      final myMarker = Marker(
          markerId: MarkerId("My Position"),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          infoWindow: InfoWindow(title: "My Location", snippet: "Udacoding"));
      _marker['Current Location'] = myMarker;
      myLocation = LatLng(currentLocation.latitude, currentLocation.longitude);
      final CameraPosition camLocation = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 15);
      changeCameraPosition(camLocation);
    });
    print("Lat : ${currentLocation.latitude}");
    print("Lon : ${currentLocation.longitude}");
  }

  void periodicMethod() async {
    _timer = Timer.periodic(Duration(seconds: 20), (test) async {
      if (this.mounted) {
        setState(() {
          getCurrentLocation();
          print("Get Location Ke ${test.tick}");
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
    periodicMethod();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
    periodicMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Detail',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                    ),
                  ),
                ],
              ),
              Card(
                margin: EdgeInsets.all(20),
                child: Stack(
                  children: <Widget>[
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Nama',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontFamily: 'Open Sans'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                              ),
                              SelectableText(
                                widget.data?.fullnameUser ?? "",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'Open Sans'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                              ),
                              Text(
                                'Check In',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontFamily: 'Open Sans'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                              ),
                              Text(
                                "${widget.data?.checkIn??"didn't check today"}",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'Open Sans'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                              ),
                              Text(
                                'Check Out',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontFamily: 'Open Sans'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                              ),
                              Text(
                                "${widget.data?.checkOut??"didn't check today"}",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'Open Sans'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                              ),
                              Text(
                                'Place',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontFamily: 'Open Sans'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                              ),
                              Text(
                                "${widget.data?.place??"didn't check today"}",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'Open Sans'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 270),
                        child: Column(
                          children: <Widget>[
                            Text("Latitude : ${myLocation?.latitude ?? 0.0}"),
                            Text("Longitude : ${myLocation?.longitude ?? 0.0}")
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 310),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: LatLng(-6.1753924, 106.8249641),
                              zoom: 15.0),
                          markers: _marker.values.toSet(),
                          onMapCreated: (controller) {
                            _controller.complete(controller);
                          },
                          gestureRecognizers:
                              <Factory<OneSequenceGestureRecognizer>>[
                            Factory<OneSequenceGestureRecognizer>(
                              () => ScaleGestureRecognizer(),
                            )
                          ].toSet(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
