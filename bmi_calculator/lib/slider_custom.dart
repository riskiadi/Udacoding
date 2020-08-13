import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SliderCustom extends StatelessWidget {
  final double value;
  final title;
  final unit;
  final double min;
  final double max;
  final Color textColor;

  final Function(double) onButtonChange;
  final Function(double) onSliderChange;

  SliderCustom(
      {Key key,
      this.value,
      this.title,
      this.unit,
      this.min,
      this.max,
      this.textColor = Colors.white,
      this.onButtonChange,
      this.onSliderChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(color: textColor, fontSize: 17),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  if (value > min) {
                    onButtonChange(-1);
                  }
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: const Color(0XFFe0e0e0),
                )),
            Container(
              width: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(-1, -2),
                    end: Alignment(1, 4),
                    colors: [const Color(0xff3950ad), const Color(0xff1C2754)]),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Slider(
                min: min,
                max: max,
                value: value,
                onChanged: (value) {
                  onSliderChange(value);
                },
              ),
            ),
            InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  if (value < max) {
                    onButtonChange(1);
                  }
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0XFFe0e0e0),
                )),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value.ceil().toString(),
              style: TextStyle(
                color: textColor,
                fontSize: 28,
              ),
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              unit,
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.w700, color: textColor),
            ),
          ],
        ),
      ],
    );
  }
}
