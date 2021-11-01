import 'package:flutter/material.dart';


import 'package:quran_kareem/presentation/widgets/custom_text.dart';

Widget customSurahNameItem(
    {String surahName, String surahNumber, Function onTap, context}) {
  var deviceHeight = MediaQuery.of(context).size.height;
  var deviceWidth = MediaQuery.of(context).size.width;

  return Padding(
    padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
    child: Container(
      width: deviceWidth * 0.6,
      height: deviceHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(
              text: surahName,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: deviceWidth < 370 ? 15 : 20,
            ),
            SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: CustomText(
                text: '${surahNumber.toString()}-',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: deviceWidth < 370 ? 15 : 20,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
