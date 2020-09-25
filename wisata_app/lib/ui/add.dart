import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:uuid/uuid.dart';
import 'package:wisata_app/models/push_model.dart';
import 'package:wisata_app/ui/map.dart';
import 'package:wisata_app/widgets/camera_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  final _scafoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  List<File> _imageFile = List<File>();
  TextEditingController cLocationName = TextEditingController();
  TextEditingController cDescription = TextEditingController();
  TextEditingController cAddress = TextEditingController();

  FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;

  double latitude;
  double longitude;

  List<String> imageUrls = List<String>();

  @override
  void initState() {
    _databaseReference =_firebaseDatabase.reference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text("Add Destination"),
        actions: [
          FlatButton(
            child: Row(
              children: [
                Icon(Icons.save, color: Colors.white,),
                SizedBox(width: 10,),
                Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            onPressed: (){
              if(_formKey.currentState.validate() && _imageFile.length>0 && latitude!=null && longitude!=null){
                _uploadImage(files: _imageFile);
              }else{
                _scafoldKey.currentState.showSnackBar(SnackBar(
                  content: Text("Some data is required"),
                ));
              }
            },
          )
        ],
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        color: Colors.black,
        opacity: 0.7,
        progressIndicator: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Please wait...", style: TextStyle(color: Colors.white),)
          ],
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                TextFormField(
                  controller: cLocationName,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Location Name",
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                  style: TextStyle(
                      fontSize: 17
                  ),
                  validator: (value) => value.isEmpty ? "Required" : null,
                ),

                TextFormField(
                  controller: cDescription,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Description",
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                  style: TextStyle(
                      fontSize: 17
                  ),
                  validator: (value) => value.isEmpty ? "Required" : null,
                ),

                Container(
                  height: 80,
                  child: Stack(
                    children: [

                    TextFormField(
                      controller: cAddress,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: "Address",
                        labelStyle: TextStyle(fontSize: 20),
                      ),
                      style: TextStyle(
                          fontSize: 17
                      ),
                      validator: (value) => value.isEmpty ? "Required" : null,
                    ),

                    Positioned(
                      right: 10,
                      top: 10,
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        child: Row(
                          children: [
                            Icon(Icons.map, size: 20, color: Colors.white,),
                            SizedBox(width: 6),
                            Text("Get", style: TextStyle(fontSize: 16, color: Colors.white),)
                          ],
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage(),)).then((value){
                            LatLng position;
                            setState(() {
                              position = value;
                              latitude = position.latitude;
                              longitude = position.longitude;
                            });
                            _geoCoder(Coordinates(position.latitude, position.longitude)).then((value){
                              setState(() {
                                cAddress.text = value.first.addressLine;
                              });
                            });

                          });
                        },
                      ),
                    ),

                    ],
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Latitude: ${latitude??"0"}"),
                      Text("Longitude: ${longitude??"0"}"),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                    child: CameraButton(
                      images: (List<String> images) {
                        setState(() {
                          _imageFile.clear();
                          images.forEach((String pathString) {
                            _imageFile.add(File(pathString));
                          });
                        });
                      },
                    ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Address>> _geoCoder(Coordinates coordinates){
    return Geocoder.local.findAddressesFromCoordinates(coordinates);
  }

  Future<void> _uploadImage({@required List<File> files}) async {
    setState(() {_isLoading = true;});
    int counter = 0;
    files.forEach((File file) async {
      final StorageReference storageReference = FirebaseStorage().ref().child(Uuid().v1());
      StorageUploadTask uploadTask = storageReference.putFile(file);
      var fileUrl = await(await uploadTask.onComplete).ref.getDownloadURL();
      setState(() {
        imageUrls.add(fileUrl.toString());
        counter++;
      });
      if(counter==files.length){
        _uploadDatabase(PushModel.fromJson(
            {
              "location_name": cLocationName.text,
              "address": cAddress.text,
              "description": cDescription.text,
              "images": imageUrls,
              "latitude": latitude,
              "longitude": longitude,
            }
        )).then((value){
          setState(() {_isLoading = false;});
          Navigator.pop(context);
        });
      }
    });

  }

  Future _uploadDatabase(PushModel pushModel) async{
    Map<String, dynamic> data = {
      "address" : pushModel.address,
      "description" : pushModel.description,
      "location_name" : pushModel.locationName,
      "latitude" : pushModel.latitude,
      "longitude" : pushModel.longitude,
      "images" : pushModel.images
    };
    await _databaseReference.push().set(data);
  }

}
