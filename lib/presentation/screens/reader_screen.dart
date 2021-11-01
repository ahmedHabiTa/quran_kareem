import 'package:flutter/material.dart';
import 'package:quran_kareem/Animation/FadeAnimation.dart';

import 'package:quran_kareem/data/quran_data.dart';
import 'package:quran_kareem/presentation/screens/ayat_screen.dart';
import 'package:quran_kareem/presentation/widgets/background_container.dart';
import 'package:quran_kareem/presentation/widgets/custom_animated_text.dart';
import 'package:quran_kareem/presentation/widgets/custom_surah_name_item.dart';
import 'package:quran_kareem/presentation/widgets/custom_text_field.dart';

// class AyatDetails {
//   final String surahName;
//
//   final List<Ayat> ayat;
//
//   const AyatDetails({
//     @required this.surahName,
//     @required this.ayat,
//   });
// }

class ReaderScreen extends StatefulWidget {
  static const routeName = '/ReaderScreen';

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

bool searchFieldVisibility = false;
final searchController = TextEditingController();

class _ReaderScreenState extends State<ReaderScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    final quranData = QuranData();
    return SafeArea(
      child: Scaffold(
        body: BackgroundContainer(
          widget: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: deviceWidth * 0.4,
                  child: customAnimatedText(
                      fontSize: deviceWidth * 0.05,
                      height: deviceHeight * 0.05,
                      width: deviceWidth,
                      text: ' قائمه السور',
                      context: context),
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
                        surahName: '${quranData.list[index]['title']}',
                        onTap: () async {
                          Navigator.of(context).pushNamed(
                              AyatScreen.routeName,
                              arguments: index);
                        },
                        surahNumber: '${index + 1}',
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
