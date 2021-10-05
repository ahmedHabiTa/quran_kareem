import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:quran_kareem/presentation/screens/first_screen.dart';
import 'package:quran_kareem/presentation/widgets/background_container.dart';
import 'package:quran_kareem/presentation/widgets/custom_animated_text.dart';
import 'package:quran_kareem/presentation/widgets/custom_text.dart';

import 'home_screen.dart';

class DailyRoutine extends StatefulWidget {
  static const routeName = '/DailyRoutine';

  @override
  _DailyRoutineState createState() => _DailyRoutineState();
}

class _DailyRoutineState extends State<DailyRoutine> {
  int _counter = 3;
  Timer _timer;
  int currentIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    currentIndex = 0;
    _counter = 3;
  }

  void _startCounter() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: currentIndex == 0
            ? FloatingActionButton(
                child: CustomText(
                  text: 'أبدأ',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
                onPressed: () {
                  if (_counter == 3) {
                    return _startCounter();
                  } else {
                    return print('cantttt');
                  }
                },
              )
            : Container(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: BackgroundContainer(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             const SizedBox(
                height: 15,
              ),
              if (currentIndex == 0 || currentIndex == 100)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: deviceWidth < 370 ? 20 : 30,
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          HomeScreen.routeName,
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    if (_counter != 0)
                      Center(
                        child: customAnimatedText(
                          width: deviceWidth * 0.85,
                          height: deviceHeight * 0.08,
                          text: 'اضفط بدأ لتستغفر ١٠٠ مره في ١٠٠ ثانيه',
                          context: context,
                          fontSize: deviceWidth * 0.05,
                        ),
                      ),
                    Spacer(),
                  ],
                ),
              _counter != 0
                  ? CustomText(
                      text: '  ستبدأ بعد ${_counter.toString()}  ثانيه',
                      fontSize: deviceWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
                  : Container(
                      height: deviceWidth * 0.06,
                    ),
              const SizedBox(
                height: 15,
              ),
              if (_counter == 0)
                CarouselSlider.builder(
                    options: CarouselOptions(
                      onPageChanged: (value, _) {
                        setState(() {
                          currentIndex = value;
                        });
                      },
                      pauseAutoPlayInFiniteScroll: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.8,
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(milliseconds: 1500),
                      autoPlayAnimationDuration: Duration(milliseconds: 1500),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    itemCount: 101,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return itemIndex == 100
                          ? const Center(
                              child: const Text(
                                'تهانينا لك,لقد اكملت 100 استغفار',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          : Center(
                              child: Stack(
                                alignment: Alignment.bottomCenter * 0.9,
                                children: [
                                   Container(
                                    height: deviceHeight * 0.4,
                                    width: deviceWidth * 0.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                          Colors.blue[800],
                                          BlendMode.overlay,
                                        ),
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/images/estkhfaar.gif'),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${(itemIndex + 1).toString()}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            );
                    }),
            ],
          ),
        ),
      ),
    );
  }
}
