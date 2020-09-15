import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:profil_sekolah/model/sekolah.dart';
import 'package:profil_sekolah/pages/alter.dart';
import 'package:profil_sekolah/pages/detail.dart';
import 'package:profil_sekolah/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<ModelSekolah> _listSekolah = List();

  String profileName;
  String profileEmail;
  String profilePhoto;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;

  StreamSubscription<Event>  _onAddedSubscription;
  StreamSubscription<Event>  _onChangedSubscription;
  StreamSubscription<Event>  _onRemovedSubscription;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleSignIn _signIn = GoogleSignIn();

  @override
  void dispose() {
    _onAddedSubscription.cancel();
    _onChangedSubscription.cancel();
    _onRemovedSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {

    _databaseReference = _database.reference().child('sekolah');
    _onAddedSubscription = _databaseReference.onChildAdded.listen((_)=>_getData());
    _onChangedSubscription = _databaseReference.onChildChanged.listen((_)=>_getData());
    _onRemovedSubscription = _databaseReference.onChildRemoved.listen((_)=>_getData());

    _getData();

    _getProfile().then((value){
      setState(() {
        profileName = value.getString('name');
        profileEmail = value.getString('email');
        profilePhoto = value.getString('photo');
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AlterPage()));
          },
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome, ",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: ClipOval(
                                child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/loading.png',
                                    image: profilePhoto
                                )
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profileName??'',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                profileEmail??'',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      FlatButton(
                        child: Text('Sign out', style: TextStyle(color: Colors.red),),
                        onPressed: (){
                          _logout();
                        },
                      ),
                    ],
                  ),
                ],
              )
            ),

            Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
              child: Text(
                'Swipe to Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),

            _listSekolah.length>0?Container():loadingWidget(),

            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: _listSekolah.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_listSekolah[index].key),
                  background: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.delete, color: Colors.white, size: 30,),
                          Icon(Icons.delete, color: Colors.white, size: 30,),
                        ],
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text(_listSekolah[index].namaSekolah)
                    ),
                    subtitle: Text(_listSekolah[index].deskripsi, maxLines: 2,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(
                        title: _listSekolah[index].namaSekolah,
                        description: _listSekolah[index].deskripsi,
                        longitude: _listSekolah[index].longitude,
                        latitude: _listSekolah[index].latitude,
                        firebaseKey: _listSekolah[index].key,
                      ),));
                    },
                  ),
                  onDismissed: (direction) {
                    _deleteData(_listSekolah[index].key);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Column loadingWidget() {
    return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ],
          );
  }



  Future<void> _getData() async {
    DataSnapshot snapshot = await _databaseReference.once();
    _listSekolah.clear();
    var keys = snapshot.value.keys;
    for(var key in keys){
      _listSekolah.add(
          ModelSekolah(
            key: key,
            namaSekolah: snapshot.value[key]["namaSekolah"],
            deskripsi: snapshot.value[key]["deskripsi"],
            latitude: double.parse(snapshot.value[key]["latitude"].toString()),
            longitude: double.parse(snapshot.value[key]["longitude"].toString()),
          )
      );
    }
    setState(() {});
  }

  _deleteData(String key) {
    _databaseReference.child(key).remove().then((_){
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Delete Successfull"),
        )
      );
    });
  }

  Future<SharedPreferences> _getProfile() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  Future<void> _logout() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    _signIn.disconnect();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage(),), (route) => false);
  }

  Future<void> _handleSignOut() => _signIn.disconnect();

}