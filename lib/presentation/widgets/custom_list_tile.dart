
import 'package:flutter/material.dart';

Widget customListTile({
  context,
  @required Function onTap,
  @required String title,
}) {
  var deviceHeight = MediaQuery.of(context).size.height;
  var deviceWidth = MediaQuery.of(context).size.width;
  return Card(
    elevation: 10,
    shadowColor: Colors.grey[900],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    color: Colors.transparent,
    margin: EdgeInsets.all(2),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black45,
        ),
        height: deviceHeight * 0.05,
        width: deviceWidth * 0.8,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: deviceWidth < 370 ? 15 : 20,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
