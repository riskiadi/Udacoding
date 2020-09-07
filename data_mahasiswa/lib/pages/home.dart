import 'dart:convert';
import 'dart:math';

import 'package:data_mahasiswa/db_helper.dart';
import 'package:data_mahasiswa/models/admin.dart';
import 'package:data_mahasiswa/models/mahasiswa.dart';
import 'package:data_mahasiswa/pages/create.dart';
import 'package:data_mahasiswa/pages/detail.dart';
import 'package:data_mahasiswa/pages/login.dart';
import 'package:data_mahasiswa/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  SharedPreferences sp;
  Admin userData;

  List<Mahasiswa> items = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    db.getAllMahasiswa().then((value){
      setState(() {
        value.forEach((element) {
          items.add(Mahasiswa.fromMap(element));
        });
      });
    });
    _getUserData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Mahasiswa'),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white,),
              onPressed: (){
                _logout();
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
        onPressed: (){
          _navigateToInput();
        },
      ),
      body: items==null || items.isEmpty ? Center(child: Text('Data Kosong')) : _buildContentView(),
    );
  }

  Future<void> _navigateToInput() async {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage(),));
    if(result=='refresh'){
      _getAllMahasiswa();
    }
  }

  Future<void> _navigateToUpdate(Map<String, dynamic> data) async {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage(data: data,),));
    if(result=='refresh'){
      _getAllMahasiswa();
    }
  }

  Widget _buildContentView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            color: Colors.redAccent,
            child: Text('Selamat Datang, ${userData.name}', style: TextStyle(fontSize: 16, color: Colors.white),),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.asset('assets/dummy_image/${Random().nextInt(4)+1}.jpg', fit: BoxFit.cover, width: 50, height: 50,),
                title: Text(items[index].nama),
                subtitle: Text(items[index].nim),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(mahasiswa: items[index],),));
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.remove_red_eye, color: Colors.blue.withOpacity(0.8),)
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: (){
                        db.deleteMahasiswa(items[index].id).then((value){
                          setState(() {
                            items.clear();
                            _getAllMahasiswa();
                            toast('Delete success');
                          });
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.delete, color: Colors.red.withOpacity(0.8),)
                      ),
                    ),
                  ],
                ),
                onTap: (){
                  _navigateToUpdate({
                    "id": items[index].id,
                    "nama": items[index].nama,
                    "nim": items[index].nim,
                    "alamat": items[index].alamat,
                    "jnsKelamin": items[index].jnsKelamin,
                    "tahun": items[index].tahun,
                  });
                },
              );
            },
          )
        ],
      ),
    );
  }

  _getAllMahasiswa(){
    db.getAllMahasiswa().then((value){
      setState(() {
        items.clear();
        value.forEach((element) {
          items.add(Mahasiswa.fromMap(element));
        });
      });
    });
  }

  _getUserData() async {
    sp = await SharedPreferences.getInstance();
    userData = Admin.fromMap(jsonDecode(sp.getString('userData')));
  }

  _logout() async{
    sp = await SharedPreferences.getInstance();
    sp.clear();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage(),), (route) => false);
  }

  toast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: CustomColor.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

}
