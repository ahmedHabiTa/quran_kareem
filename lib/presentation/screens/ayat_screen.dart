import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran/quran.dart' as quran;
import 'package:quran_kareem/controllers/provider.dart';
import 'package:quran_kareem/data/quran_data.dart';
import 'package:quran_kareem/network/local/shared_pref_helper.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:showcaseview/showcaseview.dart';

class AyatScreen extends StatefulWidget {
  static const routeName = '/AyatScreen';

  @override
  _AyatScreenState createState() => _AyatScreenState();
}

class _AyatScreenState extends State<AyatScreen> {
  final ItemScrollController itemScrollController = ItemScrollController();

  final ItemPositionsListener itemPositionsListener =
  ItemPositionsListener.create();

  final key1 = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        showCase();
      },
    );
  }
  void showCase()async{
    if(SharedPrefsHelper.getData(key: 'showCase')==null){
      ShowCaseWidget.of(context).startShowCase([key1]);
      await  SharedPrefsHelper.saveData(key: 'showCase', value: true);
    }
  }
  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var surahIndex = ModalRoute.of(context).settings.arguments as int;
    final quranData = QuranData();
    return Consumer<SaveAyaProvider>(
      builder: (context, provider, _) {
        return SafeArea(
          child: Scaffold(
            floatingActionButton: SharedPrefsHelper.getData(
                key: 'currentAyaIndex') !=
                null &&
                surahIndex == SharedPrefsHelper.getData(key: 'surahIndex')
                ? FloatingActionButton(
              backgroundColor: Colors.blue[900],
              child: Icon(Icons.arrow_downward_sharp),
              onPressed: () {
                itemScrollController.scrollTo(
                  index:
                  SharedPrefsHelper.getData(key: 'currentAyaIndex'),
                  duration: Duration(seconds: 2),
                  curve: Curves.easeInOutCubic,
                );
              },
            )
                : Container(),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Showcase(
                          key: key1,
                          description:
                          'عند الانتهاء من القراءه اضغط علي الأيه لتتمكن من العوده اليها',
                          showcaseBackgroundColor: Colors.blue[700],
                          descTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          showArrow: true,
                          shapeBorder: const CircleBorder(),
                          overlayPadding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.help_rounded,
                            size: 30,
                          ),
                        ),
                        onPressed: () {
                          ShowCaseWidget.of(context).startShowCase([key1]);
                        },
                      ),
                      Spacer(),
                      Text(
                        '${quranData.list[surahIndex]['title']}',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                    ],
                  ),
                  // Text(
                  //   '${quran.getBasmala()}',
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 22,
                  //       decoration: TextDecoration.underline,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: ScrollablePositionedList.builder(
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      itemCount: quran.getVerseCount(surahIndex + 1),
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () async {
                            provider.saveAyaIndex(
                              surahIndex: surahIndex,
                              ayaIndex: index,
                              context: context,
                              ayaText: quran.getVerse(
                                surahIndex + 1,
                                index + 1,
                                verseEndSymbol: true,
                              ),
                            );
                          },
                          // await SharedPrefsHelper.saveData(
                          //   key: 'savedAya',
                          //   value: savedIndexList,
                          // );
                          // await SharedPrefsHelper.saveData(
                          //   key: 'surahIndex',
                          //   value: surahIndex,
                          // );
                          // await SharedPrefsHelper.saveData(
                          //   key: 'ayaIndex',
                          //   value: index,
                          // );
                          tileColor: SharedPrefsHelper.getData(
                              key: 'currentAyaIndex') ==
                              index &&
                              surahIndex ==
                                  SharedPrefsHelper.getData(
                                      key: 'surahIndex')
                              ? Colors.blue[700]
                              : Colors.white,
                          title: Text(
                            '${quran.getVerse(surahIndex + 1, index + 1, verseEndSymbol: true)}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
