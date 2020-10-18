import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAlertDialog extends StatelessWidget {

  final String title;
  final String content;

  const MyAlertDialog({Key key, @required this.title, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title??''),
      content: Text(content??''),
      actions: [
        FlatButton(
          child: Text('Ok'),
          onPressed: (){
            Get.back();
          },
        )
      ],
    );
  }
}
