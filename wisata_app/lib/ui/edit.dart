import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:uuid/uuid.dart';
import 'package:wisata_app/models/content_model.dart';
import 'package:wisata_app/models/push_model.dart';
import 'package:wisata_app/ui/map.dart';
import 'package:wisata_app/widgets/camera_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

class EditPage extends StatefulWidget {

  final ContentModel contentModel;

  const EditPage({Key key, @required this.contentModel}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {


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

    setState(() {
      cLocationName.text = widget.contentModel.locationName;
      cDescription.text = widget.contentModel.locationName;
      cAddress.text = widget.contentModel.address;
      latitude = widget.contentModel.latitude;
      longitude = widget.contentModel.longitude;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text("Update Destination"),
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
              if(_formKey.currentState.validate() && _imageFile.length>0){
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
      body: Form(
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
                height: 100,
                child: Stack(
                  children: [

                    TextFormField(
                      readOnly: true,
                      controller: cAddress,
                      decoration: InputDecoration(
                        filled: true,
                        enabled: true,
                        labelText: "Address",
                        labelStyle: TextStyle(fontSize: 20),
                      ),
                      style: TextStyle(
                          fontSize: 17
                      ),
                      validator: (value) => value.isEmpty ? "Required" : null,
                    ),

                    Positioned(
                      right: 1,
                      top: 10,
                      child: FloatingActionButton(
                        mini: true,
                        child: Icon(Icons.map, size: 27,color: Colors.white,),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage(),)).then((value){
                            LatLng position;
                            setState(() {
                              _isLoading = true;
                              position = value;
                            });
                            _geoCoder(Coordinates(position.latitude, position.longitude)).then((value){
                              setState(() {
                                cAddress.text = value.first.addressLine;
                                latitude = position.latitude;
                                longitude = position.longitude;
                                _isLoading = false;
                              });
                            });

                          });
                        },
                      ),
                    ),

                  ],
                ),
              ),

              _isLoading ? CircularProgressIndicator() : Container(),


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
    );
  }

  Future<List<Address>> _geoCoder(Coordinates coordinates){
    return Geocoder.local.findAddressesFromCoordinates(coordinates);
  }

  Future<void> _uploadImage({@required List<File> files}) async {
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
    await _databaseReference.child(widget.contentModel.firebaseKey).set(data);
  }

}
