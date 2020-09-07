import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormWidget extends StatelessWidget {
  final TextEditingController textController;
  final String formHint;
  final String formLabel;
  final bool isNumberFormat;

  TextFormWidget(
      {Key key,
        this.textController,
        this.formHint,
        this.formLabel,
        this.isNumberFormat = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        validator: (value) {
          if(value==null || value.isEmpty){
            return 'please enter ${formLabel.toLowerCase()}';
          }else{
            return null;
          }
        },
        controller: textController,
        keyboardType:
        isNumberFormat == false ? TextInputType.text : TextInputType.number,
        inputFormatters: [
          isNumberFormat == false ? FilteringTextInputFormatter.singleLineFormatter : FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          hintText: formHint,
          filled: true,
          labelText: formLabel,
        ),
      ),
    );
  }
}