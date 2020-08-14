import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String labelOutput = "0";

  String _output= "0";
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operand = "";

  Widget buttonBuilder({int flexWidget = 1 ,String text, Color btnColor}) {
    return new Expanded(
      flex: flexWidget,
      child: Container(
        color: btnColor,
        child: OutlineButton(
          borderSide: BorderSide.none,
          padding: EdgeInsets.all(25.0),
          child: Text(
            text,
            maxLines: 2,
            style: GoogleFonts.montserrat(
                fontSize: 25, fontWeight: FontWeight.w300, color: Colors.white),
          ),
          onPressed: () {

            if(text == "AC"){
              setState(() {
                _output= "0";
                _num1 = 0.0;
                _num2 = 0.0;
                _operand = "";
              });
            }else if(text=="+" || text=="-" || text=="/" || text=="x" || text=="%"){
              _num1 = double.parse(labelOutput);
              _operand = text;
              _output = "0";
            }else if(text=="."){
              if(!_output.contains(".")){
                _output = _output + text;
              }
            }else if(text=="="){
              _num2= double.parse(labelOutput);
              if(_operand=="+"){
                _output = (_num1+_num2).toString();
              }else if(_operand=="-"){
                _output = (_num1-_num2).toString();
              }else if(_operand=="x"){
                _output = (_num1*_num2).toString();
              }else if(_operand=="/"){
                _output = (_num1/_num2).toString();
              }else if(_operand=="%"){
                _output = (_num1%_num2).toString();
              }

              _num1 = 0.0;
              _num2 = 0.0;
              _operand = "";

            }else{
              _output = _output + text;
            }

            setState(() {
              labelOutput = double.parse(_output).toStringAsFixed(2);
            });

          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                    alignment: Alignment.centerRight,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(labelOutput,
                          style: GoogleFonts.montserrat(
                              fontSize: 45, color: Colors.white)),
                    )),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Column(children: [
                  Row(children: [
                    buttonBuilder(
                        text: "AC", btnColor: const Color(0XFF314249)),
                    buttonBuilder(text: "x", btnColor: const Color(0XFF314249)),
                    buttonBuilder(text: "-", btnColor: const Color(0XFF314249)),
                    buttonBuilder(text: "+", btnColor: const Color(0XFF314249))
                  ]),
                  Row(children: [
                    buttonBuilder(text: "7", btnColor: const Color(0XFF202B30)),
                    buttonBuilder(text: "8", btnColor: const Color(0XFF202B30)),
                    buttonBuilder(text: "9", btnColor: const Color(0XFF202B30)),
                    buttonBuilder(text: "/", btnColor: const Color(0XFF314249))
                  ]),
                  Row(children: [
                    buttonBuilder(text: "4", btnColor: const Color(0XFF202B30)),
                    buttonBuilder(text: "5", btnColor: const Color(0XFF202B30)),
                    buttonBuilder(text: "6", btnColor: const Color(0XFF202B30)),
                    buttonBuilder(text: "%", btnColor: const Color(0XFF314249))
                  ]),
                  Row(children: [
                    buttonBuilder(text: "1", btnColor: const Color(0XFF202B30)),
                    buttonBuilder(text: "2", btnColor: const Color(0XFF202B30)),
                    buttonBuilder(text: "3", btnColor: const Color(0XFF202B30)),
                    buttonBuilder(text: ".", btnColor: const Color(0XFF314249))
                  ]),
                  Row(children: [
                    buttonBuilder(flexWidget: 2,text: "0", btnColor: const Color(0XFF202B30)),
                    buttonBuilder(text: "00", btnColor: const Color(0XFF202B30)),
                    buttonBuilder(text: "=", btnColor: const Color(0XFF4965fc)),
                  ])
                ]),
              )
            ],
          )),
    );
  }

}
