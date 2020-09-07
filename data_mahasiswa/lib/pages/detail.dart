import 'package:data_mahasiswa/models/mahasiswa.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {

  final Mahasiswa mahasiswa;

  DetailPage({Key key, @required this.mahasiswa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mahasiswa.nama, style: TextStyle(fontSize: 20),),
            SizedBox(height: 15,),
            Text(mahasiswa.nim, style: TextStyle(fontSize: 16),),
            SizedBox(height: 5,),
            Text(mahasiswa.alamat, style: TextStyle(fontSize: 16),),
            SizedBox(height: 5,),
            Text(mahasiswa.tahun.toString(), style: TextStyle(fontSize: 16),),
            SizedBox(height: 5,),
            Text(mahasiswa.jnsKelamin, style: TextStyle(fontSize: 16),),
          ],
        ),
      ),
    );
  }
}
