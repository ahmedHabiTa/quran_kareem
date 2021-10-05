import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quran_kareem/presentation/screens/first_screen.dart';
import 'package:quran_kareem/presentation/screens/second_screen.dart';
class HomeScreen extends StatelessWidget {
  static const routeName = '/HomeScreen';
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            final difference = DateTime.now().difference(dateTime);
            final isExitWarning = difference >= Duration(seconds: 2);
            dateTime = DateTime.now();
            if (isExitWarning) {
              Fluttertoast.showToast(
                  msg: "اضغط مره اخره للخروج من التطبيق",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.white,
                  textColor: Colors.black87,
                  fontSize: 16.0);
              return false;
            } else {
              return true;
            }
          },
          child: PageView(
            children: [
              SecondScreen(),
              FirstScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
