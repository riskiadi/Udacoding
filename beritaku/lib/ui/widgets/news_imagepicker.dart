import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewsImagePicker extends StatefulWidget {

  final Function(String path) filePath;
  NewsImagePicker({this.filePath});

  @override
  _NewsImagePickerState createState() => _NewsImagePickerState();
}

class _NewsImagePickerState extends State<NewsImagePicker> {

  File _file;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      children: [
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RaisedButton(
              child: Text('Take a Picture'),
              onPressed: (){
                getPicker(ImageSource.camera);
              },
            ),
            RaisedButton(
              child: Text('Browse Image'),
              onPressed: (){
                getPicker(ImageSource.gallery);
              },
            ),
          ],
        ),
        SizedBox(height: 15),
        _file==null?Container() : Image.file(_file, height: 200,),
      ],
    );
  }

  getPicker(ImageSource imageSource) async{
    final pickedImage = await ImagePicker().getImage(source: imageSource);
    if(pickedImage!=null){
      setState(() {
        _file = File(pickedImage.path);
        widget.filePath(pickedImage.path);
      });
    }
  }

}
