import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final Function onTapFunction;

  ButtonWidget({this.title, this.hasBorder=false, this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(-1, -4),
              end: Alignment(1, 4),
              colors: [const Color(0xff52c680), const Color(0xff22693e)]),
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: onTapFunction,
          borderRadius: BorderRadius.circular(30),
          child: Container(
              height: 55.0,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                ),
              )),
        ),
      ),
    );
  }
}
