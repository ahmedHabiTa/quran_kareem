import 'dart:async';

import 'package:animated_text/animated_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_kareem/Animation/FadeAnimation.dart';

import 'first_screen.dart';
import 'home_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    displaySplash();
    super.initState();
  }
  void displaySplash() {
    Timer(Duration(seconds: 4), () async {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: deviceHeight,
            width: deviceWidth,
            child: FadeAnimation(
              1,
              Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: AnimatedText(
                  alignment: Alignment.bottomCenter,
                  speed: Duration(milliseconds: 1000),
                  controller: AnimatedTextController.loop,
                  displayTime: Duration(milliseconds: 1000),
                  wordList: [
                    'َQur\'an',
                    'kareem',
                    'Qur\'an kareem',
                  ],
                  textStyle: GoogleFonts.alice(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.blue[900],
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.blue[900],
                    BlendMode.color,
                  ),
                  image: AssetImage(
                    'assets/images/quranRail.png',
                  ),
                )),
          ),
          Positioned(
            left: deviceWidth * 0.05,
            width: deviceWidth * 0.18,
            height: deviceHeight * 0.25,
            child: FadeAnimation(
                1.5,
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter:
                              ColorFilter.mode(Colors.white, BlendMode.srcATop),
                          image: AssetImage('assets/images/light-1.png'))),
                )),
          ),
          Positioned(
            left: deviceWidth * 0.35,
            width: deviceWidth * 0.12,
            height: deviceHeight * 0.16,
            child: FadeAnimation(
                2.2,
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter:
                              ColorFilter.mode(Colors.white, BlendMode.srcATop),
                          image: AssetImage('assets/images/light-1.png'))),
                )),
          ),
          Positioned(
            left: deviceWidth * 0.75,
            width: deviceWidth * 0.18,
            height: deviceHeight * 0.15,
            child: FadeAnimation(
                3,
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter:
                              ColorFilter.mode(Colors.white, BlendMode.srcATop),
                          image: AssetImage('assets/images/light-2.png'))),
                )),
          ),
        ],
      ),
    );
  }
}
