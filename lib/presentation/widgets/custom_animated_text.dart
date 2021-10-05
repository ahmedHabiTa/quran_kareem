import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

Widget customAnimatedText({
  @required String text,
  context,
  @required double height,
  @required double width,
  @required double fontSize,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.black38,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Center(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText(
                  text,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
