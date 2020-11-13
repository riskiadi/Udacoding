import 'package:flutter/material.dart';

class ConstantFile {
  final String baseUrl = "https://flutterest.000webhostapp.com/absenudacoding/Api/";
  final String imageUrl = "https://flutterest.000webhostapp.com/absenudacoding/image/";
}

progressDialog(BuildContext context) {
  showGeneralDialog(
      barrierDismissible: false,
      barrierColor: Colors.black45.withOpacity(0.65),
      context: context,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) => Center(
            child: CircularProgressIndicator(),
          ));
}
