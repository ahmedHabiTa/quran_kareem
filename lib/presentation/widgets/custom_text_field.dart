import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;

  String hintText;
  bool obscureText;
  double height;
  double width;

  String Function(String val) onValidate;
  Function(String val) onChanged;

  // String? labelText;

  CustomTextField({
    this.controller,

    this.hintText,
    this.obscureText = true,
    // required this.labelText,
    this.onValidate,
    this.onChanged,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: AlignmentDirectional.topCenter,
            end: AlignmentDirectional.bottomCenter,
            colors: [
              Colors.blue[500],
              Colors.black45,
              Colors.blue[500],
            ]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: TextFormField(
          maxLength: 15,
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(5.0),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
                // letterSpacing: 1.2,
              )),
        ),
      ),
    );
  }
}
