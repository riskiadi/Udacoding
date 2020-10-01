import 'dart:convert';

import 'package:aplikasi_berita/api.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  TextEditingController cTitle = TextEditingController();
  TextEditingController cContent = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Berita')),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: cTitle,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide.none
                      ),
                      labelText: 'Judul berita',
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: cContent,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide.none
                      ),
                      labelText: 'Konten berita',
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 30),
                  RaisedButton(
                    child: Text('Tambah'),
                    onPressed: (){
                      setState(() {
                        _isLoading=true;
                      });
                      Api().addNews(cTitle.text, cContent.text).then((Response value){
                        var response = jsonDecode(value.body);
                        _alertDialog(response['message']);
                        setState(() {
                          _isLoading=false;
                        });
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _alertDialog(String message){
    var alertDialog = AlertDialog(
      title: Text('Add'),
      content: Text(message),
      actions: [
        FlatButton(child: Text('Ok'), onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context, true);
          Api().sendNotif('Berita baru tersedia', cTitle.text);
        }),
      ],
    );
    return showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }

}
