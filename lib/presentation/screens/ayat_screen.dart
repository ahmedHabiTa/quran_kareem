import 'package:flutter/material.dart';

import 'package:quran/quran.dart' as quran;
import 'package:quran_kareem/data/quran_data.dart';
import 'package:quran_kareem/presentation/widgets/background_container.dart';

class AyatScreen extends StatelessWidget {
  static const routeName = '/AyatScreen';

  @override
  Widget build(BuildContext context) {
    var surahIndex = ModalRoute.of(context).settings.arguments as int;
    final quranData = QuranData();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange[200],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '${quranData.list[surahIndex]['title']}',
                style: TextStyle(color: Colors.black87, fontSize: 22,decoration: TextDecoration.underline,fontWeight: FontWeight.bold),
              ),
              Text(
                '${quran.getBasmala()}',
                style: TextStyle(color: Colors.black, fontSize: 22,decoration: TextDecoration.underline,fontWeight: FontWeight.bold),
              ),
              Wrap(
                textDirection: TextDirection.rtl,
                children: List.generate(quran.getVerseCount(surahIndex + 1),
                        (index) {
                      return ListTile(
                        title: Text(
                          '${quran.getVerse(surahIndex + 1, index + 1, verseEndSymbol: true)} ',
                          style: TextStyle(color: Colors.black, fontSize: 22,fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
