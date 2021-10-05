
import 'package:flutter/material.dart';

Widget customListTile({
  context,
  @required String routeName,
  @required String title,
}) {
  var deviceHeight = MediaQuery.of(context).size.height;
  var deviceWidth = MediaQuery.of(context).size.width;
  return Card(
    elevation: 10,
    shadowColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.elliptical(150, 50),
        bottomRight: Radius.elliptical(150, 50),
      ),
    ),
    color: Colors.transparent,
    margin: EdgeInsets.all(2),
    child: GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(routeName),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.elliptical(150, 50),
            bottomRight: Radius.elliptical(150, 50),
          ),
          color: Colors.black87,
        ),
        height: deviceHeight * 0.08,
        width: deviceWidth * 0.65,
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
