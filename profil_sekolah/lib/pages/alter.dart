import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:profil_sekolah/model/sekolah.dart';
import 'package:profil_sekolah/pages/home.dart';

class AlterPage extends StatefulWidget {

  final String firebaseKey;
  final String namaSekolah;
  final String deskripsi;
  final double latitude;
  final double longitude;

  const AlterPage({Key key, this.firebaseKey, this.namaSekolah, this.deskripsi, this.latitude, this.longitude}) : super(key: key);

  @override
  _AlterPageState createState() => _AlterPageState();
}

class _AlterPageState extends State<AlterPage> {

  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;

  var keyForm = GlobalKey<FormState>();
  var cNamaSekolah = TextEditingController();
  var cDeskripsi = TextEditingController();
  var cLatitude = TextEditingController();
  var cLongitude = TextEditingController();

  @override
  void initState() {
    _databaseReference = _firebaseDatabase.reference().child('sekolah');

    if(widget.firebaseKey!=null){
      cNamaSekolah.text=widget.namaSekolah;
      cDeskripsi.text=widget.deskripsi;
      cLatitude.text=widget.latitude.toString();
      cLongitude.text=widget.longitude.toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Sekolah'),),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: keyForm,
          child: ListView(
            children: [

              TextFormField(
                controller: cNamaSekolah,
                decoration: InputDecoration(
                  labelText: 'Nama Sekolah',
                  filled: true,
                ),
                validator: (value) {
                  return value.isEmpty ? "Harus diisi": null;
                },
              ),

              TextFormField(
                controller: cDeskripsi,
                decoration: InputDecoration(
                  labelText: 'Alamat Sekolah',
                  filled: true,
                ),
                validator: (value) {
                  return value.isEmpty ? "Harus diisi": null;
                },
              ),

              TextFormField(
                controller: cLatitude,
                decoration: InputDecoration(
                  labelText: 'Latitude',
                  filled: true,
                ),
                validator: (value) {
                  return value.isEmpty ? "Harus diisi": null;
                },
              ),

              TextFormField(
                controller: cLongitude,
                decoration: InputDecoration(
                  labelText: 'Longitude',
                  filled: true,
                ),
                validator: (value) {
                  return value.isEmpty ? "Harus diisi": null;
                },
              ),

              SizedBox(height: 20,),

              RaisedButton(
                child: Text(widget.firebaseKey==null?'Tambah':'Ubah'),
                color: Colors.blue,
                onPressed: (){
                  if(keyForm.currentState.validate()){

                    _pushData(
                      namaSekolah: cNamaSekolah.text,
                      deskripsi: cDeskripsi.text,
                      latitude: double.parse(cLatitude.text),
                      longitude: double.parse(cLongitude.text),
                    ).then((value){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
                    });

                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pushData({String namaSekolah, String deskripsi, double latitude, double longitude}) async{
    ModelSekolah modelSekolah = ModelSekolah(namaSekolah: namaSekolah, deskripsi: deskripsi, latitude: latitude, longitude: longitude);
    if(widget.firebaseKey==null){
      await _databaseReference.push().set(modelSekolah.toJson());
    }else{
      await _databaseReference.child(widget.firebaseKey).set(modelSekolah.toJson());
    }
  }

}
