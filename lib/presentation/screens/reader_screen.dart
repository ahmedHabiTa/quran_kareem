import 'package:flutter/material.dart';

import 'package:quran_kareem/data/quran_data.dart';
import 'package:quran_kareem/model/surahModel.dart';
import 'package:quran_kareem/presentation/screens/ayat_screen.dart';
import 'package:quran_kareem/presentation/screens/home_screen.dart';
import 'package:quran_kareem/presentation/widgets/background_container.dart';
import 'package:quran_kareem/presentation/widgets/custom_animated_text.dart';
import 'package:quran_kareem/presentation/widgets/custom_surah_name_item.dart';
import 'package:quran_kareem/presentation/widgets/custom_text.dart';
import 'package:quran_kareem/presentation/widgets/loading_logo.dart';

import 'first_screen.dart';

class AyatDetails {
  final String surahName;

  final List<Ayat> ayat;

  const AyatDetails({
    @required this.surahName,
    @required this.ayat,
  });
}

class ReaderScreen extends StatelessWidget {
  static const routeName = '/ReaderScreen';

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    final quranData = QuranData();
    return SafeArea(
      child: Scaffold(
        body:  BackgroundContainer(
          widget: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: deviceWidth * 0.4,
                      child: customAnimatedText(
                          fontSize: deviceWidth * 0.05,
                          height: deviceHeight * 0.05,
                          width: deviceWidth,
                          text: ' قائمه السور',
                          context: context),
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return customSurahNameItem(
                      context: context,
                      surahName:
                      '${quranData.list[index]['title']}',
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AyatScreen.routeName,
                          arguments: index
                        );
                      },
                      surahNumber: '${index+1}',
                    );
                  },
                  itemCount: quranData.list.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
