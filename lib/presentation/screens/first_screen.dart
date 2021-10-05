import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quran_kareem/presentation/widgets/custom_animated_text.dart';
import 'package:quran_kareem/presentation/widgets/custom_list_tile.dart';


import 'quran_player_screen.dart';
import 'second_screen.dart';

class FirstScreen extends StatefulWidget {
  static const routeName = 'FirstPage';

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return  Stack(
      children: [
        Container(
          height: deviceHeight,
          width: deviceWidth,
          color: Theme.of(context).canvasColor,
        ),
        Positioned(
          top: deviceHeight * 0.02,
          left: deviceWidth * 0.06,
          right: deviceWidth * 0.06,
          child: customAnimatedText(
              height: deviceHeight*0.05,
              width: deviceWidth,
              text: 'لا تنسي الصلاه علي النبي',
              context: context,
              fontSize: deviceWidth*0.05
          ),
        ),
        Positioned(
          top: deviceHeight * 0.09,
          left: deviceWidth * 0.06,
          right: deviceWidth * 0.06,
          child: Column(
            children: [
              customListTile(
                context: context,
                title: ' المصحف الشريف',
                routeName: MusicPlayerScreen.routeName,
              ),
              SizedBox(height: 10,),
              customListTile(
                context: context,
                title: ' استمع الي القران',
                routeName: MusicPlayerScreen.routeName,
              ),
              SizedBox(height: 10,),
              customListTile(
                context: context,
                title: ' استمع الي القران',
                routeName: MusicPlayerScreen.routeName,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
