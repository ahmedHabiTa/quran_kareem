import 'package:flutter/material.dart';
import 'package:quran_kareem/Components/constants.dart';
import 'package:quran_kareem/network/local/shared_pref_helper.dart';

class SaveAyaProvider extends ChangeNotifier {
  List<String> savedAyaIndexList = [];

  saveAyaIndex(
      {String ayaText,
      BuildContext context,
      int ayaIndex,
      int surahIndex}) async {
    await SharedPrefsHelper.saveData(
      key: 'surahIndex',
      value: surahIndex,
    );
    if (savedAyaIndexList.contains(ayaText)) {
      savedAyaIndexList.remove(ayaText);
      await SharedPrefsHelper.deleteData(
        key: 'currentAyaIndex',
      );
      notifyListeners();
    } else {
      savedAyaIndexList.clear();
      savedAyaIndexList.add(ayaText);
      await SharedPrefsHelper.saveData(key: 'currentAyaIndex', value: ayaIndex);
      Constants.get(context).showToast(msg: 'تم الحفظ', color: Colors.black45);
      notifyListeners();
    }
    savedAyaIndexList = savedAyaIndexList ;
    notifyListeners();
  }
}
