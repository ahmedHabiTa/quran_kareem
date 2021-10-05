import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Constants{
  static Constants get(context) => Constants();
  // ignore: missing_return
  Future<bool> showToast(String toastMsg){
    Fluttertoast.showToast(
        msg: toastMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}