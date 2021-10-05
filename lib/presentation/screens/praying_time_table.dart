import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quran_kareem/model/pray_time_model.dart';
import 'package:http/http.dart' as http;
import 'package:quran_kareem/presentation/screens/city_category_screen.dart';
import 'package:quran_kareem/presentation/widgets/background_container.dart';
import 'package:quran_kareem/presentation/widgets/custom_animated_text.dart';
import 'package:quran_kareem/presentation/widgets/custom_text.dart';
import 'package:quran_kareem/presentation/widgets/loading_logo.dart';

class PrayTimes extends StatefulWidget {
  static const routeName = '/PrayTimes';

  @override
  _PrayTimesState createState() => _PrayTimesState();
}

class _PrayTimesState extends State<PrayTimes> {
  PrayTimeModel _prayTimeModel;

  @override
  Widget build(BuildContext context) {
    final cityName = ModalRoute.of(context).settings.arguments as CityArguments;
    final String url =
        'http://api.aladhan.com/v1/timingsByCity?city=${cityName.cityEnglish}&country=Egypt&method=5';

    Future getPrayTimeData() async {
      http.Response res = await http.get(Uri.parse(url), headers: {
        "Accept":
            "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
      });
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        _prayTimeModel = PrayTimeModel.fromJson(data);
        return _prayTimeModel;
      } else {
        throw UnimplementedError();
      }
    }

    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: getPrayTimeData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return BackgroundContainer(
                  widget: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: deviceWidth < 370
                                ? deviceWidth * 0.06
                                : deviceWidth * 0.075,
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                CityCategoryScreen.routeName,
                              );
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: deviceWidth * 0.6,
                            child: customAnimatedText(
                                fontSize: deviceWidth * 0.05,
                                height: deviceHeight * 0.05,
                                width: deviceWidth,
                                text: '  توقيت : ${cityName.cityArabic}',
                                context: context),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: Colors.black12,
                        elevation: 30,
                        shadowColor: Colors.black12,
                        child: Container(
                          height: deviceHeight * 0.4,
                          width: deviceWidth * 0.75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: deviceWidth * 0.15,
                              ),
                              child: Table(
                                children: [
                                  customTableRow(
                                    prayName: 'الفجر',
                                    prayTime: snapshot.data.data.timings.fajr,
                                  ),
                                  customTableRow(
                                    prayName: 'الشروق',
                                    prayTime:
                                        snapshot.data.data.timings.sunrise,
                                  ),
                                  customTableRow(
                                    prayName: 'الظهر',
                                    prayTime: snapshot.data.data.timings.dhuhr,
                                  ),
                                  customTableRow(
                                    prayName: 'العصر',
                                    prayTime: snapshot.data.data.timings.asr,
                                  ),
                                  customTableRow(
                                    prayName: 'المغرب',
                                    prayTime:
                                        snapshot.data.data.timings.maghrib,
                                  ),
                                  customTableRow(
                                    prayName: 'العشاء',
                                    prayTime: snapshot.data.data.timings.isha,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: CustomText(
                              text:
                                  'Timezone :${_prayTimeModel.data.meta.timezone}',
                              fontSize: deviceWidth * 0.05,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return BackgroundContainer(
                  widget: Center(
                    child: Center(
                      child: LoadingShimmer(),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  customTableRow({
    @required String prayTime,
    @required String prayName,
  }) {
    return TableRow(
      children: [
        keyText(prayTime, context),
        keyText(prayName, context),
      ],
    );
  }

  Widget keyText(String msg, context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Text(
      msg,
      style: TextStyle(
          fontSize: deviceWidth * 0.055,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    );
  }
}
