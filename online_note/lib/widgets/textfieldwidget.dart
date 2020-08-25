import 'package:flutter/material.dart';

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
      style: TextStyle(color: Colors.white),
      cursorColor: const Color(0xff6aa0e1),
      decoration: InputDecoration(
        labelText: hintText,
        hintStyle: TextStyle(color: const Color(0xff909090)),
        fillColor: const Color(0xFF1f1f1f),
        filled: true,
        labelStyle: TextStyle(color: const Color(0xff6aa0e1)),
        prefixIcon:
            Icon(prefixIconData, size: 18, color: const Color(0xff6aa0e1)),
        enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: const Color(0xff6aa0e1))),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
      ),
      validator: validator!=null ? validator : isAutoValidator ? (String value)=>value.isEmpty ? '$hintText is required' : null : null,
    );
  }
}
