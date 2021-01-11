import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

const dailyCat = "1";
const vegetableCat = "2";
const fruitCat = "3";
const otherCat = "4";
const String sicepat = "https://raw.githubusercontent.com/alamsyahh15/assetme/master/twt_clone/sicepat.png";
const String bcaLogo = "https://raw.githubusercontent.com/alamsyahh15/assetme/master/twt_clone/bca.png";
const String dummySeller =
    "https://raw.githubusercontent.com/alamsyahh15/assetme/master/twt_clone/alamsyah.png";
const String dummyImage =
    "https://raw.githubusercontent.com/alamsyahh15/assetme/master/twt_clone/yoghurt.png";
const Color baseColor = Color(0xFF47B04B);
const baseUrl = "http://flutterest.000webhostapp.com/server_commerce/index.php/Api/";
const imageUrl = "http://flutterest.000webhostapp.com/server_commerce/image_growback/";
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';


Random _rnd = Random();

String generateCode(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

Widget separatorItem() {
  return Divider(thickness: 15, color: Colors.black.withOpacity(0.1));
}

Future goTo(BuildContext context, Widget widget) async {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => widget));
}

String dateFormat(DateTime date){
  if(date != null){
    return DateFormat("dd MMM yyyy").format(date);
  }else{
    return "-";
  }
}

enum TypeMonFormat { Decimal, NonDecimal }

String moneyFormat(number, {TypeMonFormat type}) {
  if (type == TypeMonFormat.Decimal) {
    if (number is String) {
      return NumberFormat.currency(
              locale: 'id', decimalDigits: 0, symbol: "Rp ")
          .format(double.parse(number));
    } else {
      return NumberFormat.currency(
              locale: 'id', decimalDigits: 0, symbol: "Rp ")
          .format(number);
    }
  } else {
    if (number is String) {
      return NumberFormat.compact(locale: 'id').format(double.parse(number));
    } else {
      return NumberFormat.compact(locale: 'id').format(number);
    }
  }
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


Widget listLoading() {
  return Container(
    margin: EdgeInsets.only(top: 16),
    height: 250,
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: 150,
          color: Colors.grey[300],
          child: Card(
            elevation: 5,
            child: Stack(
              children: <Widget>[
                Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Container(
                      height: double.infinity,
                      color: Colors.grey[300],
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    width: double.infinity,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: baseColor,
                      child: Text("Beli"),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
