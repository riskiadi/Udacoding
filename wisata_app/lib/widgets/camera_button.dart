import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraButton extends StatefulWidget {

  final Function(List<String>) images;

  const CameraButton({Key key, this.images}) : super(key: key);

  @override
  _CameraButtonState createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {
  List<String> _imagePath = List<String>();
  final _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 5),
              child: RaisedButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.camera_alt),
                    SizedBox(width: 10),
                    Text('Choose Image')
                  ],
                ),
                onPressed: () => _getImage(),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _imagePath.length<=0 ? 1 : _imagePath.length,
                itemBuilder: (context, index) {
                  return _imagePath.length<=0 ? imagePlaceHolder(index) : imageContent(index);
                },
              ),
            ),
          ],
        ),
      );
  }

  Container imageContent(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          File(_imagePath[index]),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Container imagePlaceHolder(int index) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(10)
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Icon(Icons.image),
    );
  }

  _getImage() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Choose image picker"),
          actions: [
            FlatButton(
              child: Text("Gallery"),
              onPressed: () async {
                PickedFile pickedFile =  await _imagePicker.getImage(source: ImageSource.gallery);
                setState(() {
                  _imagePath.add(pickedFile.path);
                  widget.images(_imagePath);
                });
              },
            ),
            FlatButton(
              child: Text("Camera"),
              onPressed: () async {
                PickedFile pickedFile =  await _imagePicker.getImage(source: ImageSource.camera);
                setState(() {
                  _imagePath.add(pickedFile.path);
                  widget.images(_imagePath);
                });
              },
            ),
          ],
        );
      },
    );


  }

}
