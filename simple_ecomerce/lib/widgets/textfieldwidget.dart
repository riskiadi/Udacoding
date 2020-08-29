import 'package:flutter/material.dart';
import 'package:simple_ecomerce/const/custom_color.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final TextInputType inputType;
  final Function onChanged;
  final Function validator;
  final bool isAutoValidator;

//  Function autoValidator = (String value)=>value.isEmpty ? '$hintText is required' : null;

  TextFieldWidget({
    this.textController,
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    this.obscureText,
    this.inputType = TextInputType.text,
    this.validator,
    this.isAutoValidator=false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: obscureText,
      onChanged: onChanged,
      keyboardType: inputType,
      style: TextStyle(color: Colors.black),
      cursorColor: CustomColor.red,
      decoration: InputDecoration(
        labelText: hintText,
        hintStyle: TextStyle(color: const Color(0xff909090)),
        labelStyle: TextStyle(color: CustomColor.red),
        prefixIcon: Icon(prefixIconData, size: 18, color: CustomColor.red),
        enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: CustomColor.red),
        ),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 5, color: CustomColor.red),
        ),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
      ),
      validator: validator!=null ? validator : isAutoValidator ? (String value)=>value.isEmpty ? '$hintText is required' : null : null,
    );
  }
}
