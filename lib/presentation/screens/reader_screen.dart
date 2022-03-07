import 'package:flutter/material.dart';
import 'package:quran_kareem/data/quran_data.dart';
import 'package:quran_kareem/presentation/screens/ayat_screen.dart';
import 'package:quran_kareem/presentation/widgets/background_container.dart';
import 'package:quran_kareem/presentation/widgets/custom_animated_text.dart';
import 'package:quran_kareem/presentation/widgets/custom_list_tile.dart';
import 'package:quran_kareem/presentation/widgets/custom_surah_name_item.dart';

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
        body: Stack(
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
                  height: deviceHeight * 0.05,
                  width: deviceWidth,
                  text: 'قائمه السور',
                  context: context,
                  fontSize: deviceWidth * 0.05),
            ),
            Positioned(
              top: deviceHeight * 0.09,
              left: deviceWidth * 0.06,
              right: deviceWidth * 0.06,
              child: SizedBox(
                height: deviceHeight*0.82,
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom:12.0),
                      child: customListTile(
                          context: context,
                          title: '${quranData.list[index]['title']}' ,
                          onTap: () async {
                            Navigator.of(context)
                                .pushNamed(AyatScreen.routeName, arguments: index);
                          }),
                    );
                  },
                  itemCount: quranData.list.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
