import 'package:firebase_database/firebase_database.dart';

class ModelSekolah{

  final String key;
  final String namaSekolah;
  final String deskripsi;
  final double latitude;
  final double longitude;


  ModelSekolah({this.key, this.namaSekolah, this.deskripsi, this.latitude,this.longitude});

  ModelSekolah.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        namaSekolah = snapshot.value['namaSekolah'],
        deskripsi = snapshot.value['deskripsi'],
        latitude = snapshot.value['latitude'],
        longitude = snapshot.value['longitude'];

  Map<String, dynamic> toJson(){
    return {
      'namaSekolah' : namaSekolah,
      'deskripsi' : deskripsi,
      'latitude' : latitude,
      'longitude' : longitude,
    };
  }

}