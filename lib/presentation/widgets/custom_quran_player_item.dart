import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customQuranPlayerItem({String title, Function onTap, context}) {
  var deviceHeight = MediaQuery.of(context).size.height;
  var deviceWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
    child: Container(
      width: deviceWidth * 0.6,
      height: deviceHeight * 0.1,
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(
              width: 25,
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey[100],
                      Colors.grey[700],
                      Colors.grey[900],
                      Colors.grey[700],
                      Colors.grey[100],
                    ],
                  ),
                  shape: BoxShape.circle),
              child: Icon(
                Icons.play_arrow_outlined,
                color: Colors.white,
                size: deviceWidth < 370 ? 40 : 50,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 22),
              child: Text(
                "$title ",
                style: GoogleFonts.alice(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: deviceWidth < 370 ? 15 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
