import 'dart:io';
import 'package:absent_udacoding/constant/ConstantFile.dart';
import 'package:absent_udacoding/model/ModelUpdate.dart';
import 'package:absent_udacoding/ui_page/user/DetailUser.dart';
import 'package:absent_udacoding/ui_page/profile/ProfilePage.dart';
import 'package:path/path.dart' as path;
import 'package:absent_udacoding/network/NetworkProvider.dart';
import 'package:absent_udacoding/utils/SessionManager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UpdateProfile extends StatefulWidget {
  String id, nama, email, photo, phone, role;
  UpdateProfile(
      {this.nama, this.email, this.photo, this.id, this.phone, this.role});
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController etName;
  TextEditingController etEmail;
  TextEditingController etRole;
  TextEditingController etPhone;
  TextEditingController etFullName;
  File _image;
  SessionManager sessionManager = SessionManager();
  BaseEndPoint network = NetworkProvider();
  String _valRole;
  List<DataRole> _dataRole = List();

  void getRole() async {
    await network.getRole().then((value) {
      setState(() {
        _dataRole = value;
      });
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future getImage(ImageSource media) async {
    var img = await ImagePicker.pickImage(source: media);
    setState(() {
      _image = img;
    });
  }

  void checkUpdate() {
    if (_image == null) {
      network.updateProfile(widget.id, etName.text.toString(),
          etEmail.text.toString(), widget.role, etPhone.toString());
      sessionManager.savePreference(
          true,
          widget.id,
          etName.text.toString(),
          etEmail.text.toString(),
          widget.role,
          etPhone.text.toString(),
          etFullName.toString(),
          path.basename(_image.path));
    } else {
      network.updateImage(widget.id, _image);
      network.updateProfile(widget.id, etName.text.toString(), widget.role,
          etEmail.text.toString(),  etPhone.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      etName = TextEditingController(text: widget.nama);
      etEmail = TextEditingController(text: widget.email);
      etPhone = TextEditingController(text: widget.phone);
      etRole = TextEditingController(text: widget.role);
      getRole();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 16, right: 16),
                      child: _image == null
                          ? GestureDetector(
                              onTap: () {
                                myAlert();
                              },
                              child: Container(
                                height: 75,
                                width: 75,
                                child: CircleAvatar(
                                  radius: 100,
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _image,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 5,
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 210),
                            child: Text(
                              'Name',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          TextFormField(
                            controller: etName,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 220, top: 30),
                            child: Text(
                              'Role',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropdownButton(
                            isExpanded: true,
                            hint: Text('Select Role Name'),
                            value: _valRole,
                            items: _dataRole.map((item) {
                              return DropdownMenuItem(
                                child: Text(item.nameRole),
                                value: item.nameRole,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _valRole = value;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 210, top: 30),
                            child: Text(
                              'Email',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          TextFormField(
                            controller: etEmail,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 210, top: 30),
                            child: Text(
                              'Phone',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          TextFormField(
                            controller: etPhone,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: RaisedButton(
                        color: Colors.green,
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          checkUpdate();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailUser()));
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
