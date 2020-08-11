import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function onChanged;

  TextFieldWidget(
      {this.hintText,
      this.prefixIconData,
      this.suffixIconData,
      this.obscureText,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      onChanged: onChanged,
      style: TextStyle(
        color: Colors.white
      ),
      cursorColor: const Color(0xffED981C),
      decoration: InputDecoration(
          labelText: hintText,
          hintStyle: TextStyle(color: const Color(0xff909090)),
          fillColor: const Color(0xFF1f1f1f),
          filled: true,
          labelStyle: TextStyle(color: const Color(0xffED981C)),
          prefixIcon: Icon(
              prefixIconData,
              size: 18,
              color: const Color(0xffED981C)),
          enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: const Color(0xffED981C))
        )
      ),
    );
  }
}
