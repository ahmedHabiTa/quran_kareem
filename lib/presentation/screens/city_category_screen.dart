import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:quran_kareem/Components/constants.dart';
import 'package:quran_kareem/data/city_data.dart';
import 'package:quran_kareem/presentation/screens/praying_time_table.dart';
import 'package:quran_kareem/presentation/widgets/custom_animated_text.dart';
import 'package:quran_kareem/presentation/widgets/custom_list_tile.dart';

class CityArguments {
  final String cityArabic;
  final String cityEnglish;

  CityArguments({
    @required this.cityArabic,
    @required this.cityEnglish,
  });
}

class CityCategoryScreen extends StatelessWidget {
  static const routeName = '/CityCategoryScreen';

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    City city = City();
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
                  text: 'اختر مدينتك',
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
                  itemCount: city.cityConverter.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: customListTile(
                        title: '${city.cityConverter[index]['ar']}',
                        context: context,
                        onTap: ()async{
                          var connectionState =
                          await Connectivity().checkConnectivity();
                          if (connectionState == ConnectivityResult.none) {
                            Constants.get(context)
                                .showToast(msg: 'خطأ الاتصال بالانترنت');
                          } else {
                            Navigator.of(context).pushNamed(
                              PrayTimes.routeName,
                              arguments: CityArguments(
                                  cityArabic: city.cityConverter[index]['ar'],
                                  cityEnglish: city.cityConverter[index]['en']),
                            );
                          }
                        }
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
