import 'dart:math';

import 'package:bmi_calculator/button_widget.dart';
import 'package:bmi_calculator/slider_custom.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:backdrop_modal_route/backdrop_modal_route.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scafoldKey = GlobalKey<ScaffoldState>();

  double valueSlider = 0;
  double sliderMin = 0;
  double sliderMax = 40;

  double sliderHeight = 10;
  double sliderWeight = 10;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scafoldKey,
        backgroundColor: Color.fromRGBO(29, 33, 62, 100),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "BMI Calculator",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SliderCustom(
                    key: Key("slider1"),
                    title: "Body Height",
                    unit: "Cm",
                    min: 1,
                    max: 400,
                    value: sliderHeight,
                    onSliderChange: (double value) =>
                        setState(() => sliderHeight = value.ceil().toDouble()),
                    onButtonChange: (double value) =>
                        setState(() => sliderHeight += value),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SliderCustom(
                    key: Key("slider2"),
                    title: "Body Weight",
                    unit: "Kg",
                    min: 1,
                    max: 300,
                    value: sliderWeight,
                    onSliderChange: (double value) =>
                        setState(() => sliderWeight = value.ceil().toDouble()),
                    onButtonChange: (double value) =>
                        setState(() => sliderWeight += value),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  width: 200,
                  child: ButtonWidget(
                    title: "Calculate",
                    onTapFunction: () async {
                      var bmi =
                          bmiCalc(weight: sliderWeight, height: sliderHeight);

                      if (bmi >= 0 && bmi <= 40) {
                        valueSlider = bmi;
                      } else if (bmi > sliderMax) {
                        valueSlider = sliderMax;
                      } else if (bmi < sliderMin) {
                        valueSlider = sliderMin;
                      }

                      await Navigator.push(
                        context,
                        BackdropModalRoute<void>(
                          backgroundColor: Color(0XFF293362),
                          overlayContentBuilder: (context) {
                            return Column(
                              children: [
                                SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(0),
                                  child: InkWell(
                                      borderRadius: BorderRadius.circular(30),
                                      onTap: () => Navigator.pop(context),
                                      child: Icon(
                                        Icons.close,
                                        size: 25,
                                        color: Colors.white,
                                      )),
                                ),
                                SizedBox(height: 50),
                                SleekCircularSlider(
                                  appearance: CircularSliderAppearance(
                                      customColors: CustomSliderColors(
                                          trackColor: const Color(0xFFE5E5E5),
                                          hideShadow: true,
                                          progressBarColors: [
                                            const Color(0XFFf44336),
                                            const Color(0XFFf44336),
                                            const Color(0XFFffc107),
                                            const Color(0XFFffc107),
                                            const Color(0XFF4caf50),
                                            const Color(0XFF4caf50),
                                            const Color(0XFF2196f3),
                                            const Color(0XFF2196f3)
                                          ]),
                                      size: 180,
                                      customWidths: CustomSliderWidths(
                                          trackWidth: 3,
                                          progressBarWidth: 14,
                                          handlerSize: 4)),
                                  min: sliderMin,
                                  max: sliderMax,
                                  initialValue: valueSlider,
                                  innerWidget: (double value) {
                                    String status = "";

                                    if (value < 18.5) {
                                      status = "Underweight";
                                    } else if (value >= 18.5 && bmi < 24.99) {
                                      status = "Healthy";
                                    } else if (value >= 25.0 && bmi < 29.99) {
                                      status = "Pre-Obesity";
                                    } else if (value >= 30.0 && bmi < 34.99) {
                                      status = "Obesity 1";
                                    } else if (value >= 35.0 && bmi < 39.99) {
                                      status = "Obesity 2";
                                    } else if (value >= 40.0) {
                                      status = "Obesity 3";
                                    }

                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(
                                            value.toStringAsFixed(2),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "$status",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                Container(
                                  child: Text(
                                    instruction(valueSlider),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 40),
                                bmiInfo(
                                    color: const Color(0XFF2196f3),
                                    title: "Underweight",
                                    detail: "< 18.5"),
                                bmiInfo(
                                    color: const Color(0XFF4caf50),
                                    title: "Healthy",
                                    detail: "18.5-24.9"),
                                bmiInfo(
                                    color: const Color(0XFFffc107),
                                    title: "Pre-Obesity",
                                    detail: "25.0-29.9"),
                                bmiInfo(
                                    color: const Color(0XFFf44336),
                                    title: "Obesity 1",
                                    detail: "30.0-34.9"),
                                bmiInfo(
                                    color: const Color(0XFFf44336),
                                    title: "Obesity 2",
                                    detail: "35.0-39.9"),
                                bmiInfo(
                                    color: const Color(0XFFf44336),
                                    title: "Obesity 3",
                                    detail: "> 40.0"),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget bmiInfo(
      {@required Color color,
      @required String title,
      @required String detail}) {
    return Padding(
      padding: const EdgeInsets.only(right: 80, left: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                color: color,
                height: 9,
                width: 9,
                margin: EdgeInsets.only(right: 10),
              ),
              Text(title, style: TextStyle(color: Colors.white))
            ],
          ),
          Text(detail, style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }

  String instruction(double value) {
    var bmi = bmiCalc(weight: sliderWeight, height: sliderHeight);
    if (value < 18.5) {
      return "You must to eat";
    } else if (value >= 18.5 && bmi < 24.99) {
      return "Congratulation!";
    } else if (value >= 25.0 && bmi < 29.99) {
      return "Be careful";
    } else if (value >= 30.0 && bmi < 34.99) {
      return "Time to workout";
    } else if (value >= 35.0 && bmi < 39.99) {
      return "Time to workout";
    } else if (value >= 40.0) {
      return "Time to workout";
    } else {
      return "";
    }
  }

  double bmiCalc({double weight, double height}) {
    return weight / ((height * 0.01) * (height * 0.01));
  }
}
