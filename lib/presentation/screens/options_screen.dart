import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_kareem/presentation/screens/azkar_screen.dart';
import 'package:quran_kareem/presentation/screens/city_category_screen.dart';
import 'package:quran_kareem/presentation/screens/daily_routine.dart';
import 'package:quran_kareem/presentation/screens/reader_screen.dart';
import 'package:quran_kareem/presentation/widgets/custom_animated_text.dart';

import 'package:quran_kareem/presentation/widgets/custom_card.dart';

import 'children_screen.dart';

class OptionsScreen extends StatefulWidget {
  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen>
    with AutomaticKeepAliveClientMixin<OptionsScreen> {
  bool get wantKeepAlive => true;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: deviceHeight,
          width: deviceWidth,
          color: Theme.of(context).canvasColor,
        ),
        customPositionedLogo(
          height: deviceHeight * 0.3,
          width: deviceWidth * 0.45,
          imageAsset: 'assets/images/grad_logo.png',
          top: 0.0,
          right: 0.0,
        ),
        Positioned(
          top: 40,
          left: 10,
          child: Container(
            height: deviceHeight * 0.3,
            width: deviceWidth * 0.45,
            child: Text(
              'The\nHoly\nQuran',
              style: GoogleFonts.lobster(
                textStyle: TextStyle(
                  fontSize: deviceHeight * 0.065,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        customPositionedLogo(
          height: deviceHeight * 0.4,
          width: deviceWidth * 0.85,
          imageAsset: 'assets/images/quranRail.png',
          bottom: 0.0,
          left: 0.0,
        ),
        Positioned(
          top: deviceHeight * 0.24,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  CustomCard(
                    title: 'مواعيد الصلاه',
                    routeName: CityCategoryScreen.routeName,
                  ),
                  CustomCard(
                    title: 'القراءه',
                    routeName: ReaderScreen.routeName,
                  ),
                  CustomCard(
                    title: 'الاذكار',
                    routeName: AzkarScreen.routeName,
                  ),
                  CustomCard(
                    title: 'الاستغفار اليومي',
                    routeName: DailyRoutine.routeName,
                  ),
                  CustomCard(
                    title: 'الاسلام للأطفال مع زكريا',
                    routeName: ChildrenScreen.routeName,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: deviceHeight * 0.1,
          right: deviceWidth * 0.05,
          left: deviceWidth * 0.05,
          child: customAnimatedText(
            fontSize: deviceWidth * 0.05,
            text:
                'إِنَّ اللَّهَ وَمَلائِكَتَهُ يُصَلُّونَ عَلَى النَّبِيِّ يَا أَيُّهَا الَّذِينَ آمَنُوا صَلُّوا عَلَيْهِ وَسَلِّمُوا تَسْلِيمًا',
            height: deviceHeight * 0.09,
            width: deviceWidth,
            context: context,
          ),
        ),
      ],
    );
  }

  Widget customPositionedLogo({
    double right,
    double top,
    double left,
    double bottom,
    @required double height,
    @required double width,
    @required String imageAsset,
  }) {
    return Positioned(
      right: right,
      bottom: bottom,
      left: left,
      top: top,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Colors.blue[900],
              BlendMode.color,
            ),
            image: AssetImage(
              imageAsset,
            ),
          ),
        ),
      ),
    );
  }
}
