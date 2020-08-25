import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {

  final String imageURI;

  DetailPage({Key key, this.imageURI}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(imageURI),
    );
  }
}
