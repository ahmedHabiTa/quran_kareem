import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_kareem/Components/constants.dart';
import 'package:quran_kareem/data/city_data.dart';
import 'package:quran_kareem/presentation/screens/praying_time_table.dart';
import 'package:quran_kareem/presentation/widgets/custom_animated_text.dart';

import 'first_screen.dart';
import 'home_screen.dart';

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
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.blue[900],
                  BlendMode.multiply,
                ),
                fit: BoxFit.fill,
                image: AssetImage(
                    'assets/images/Green-Tropical-Plant-Wallpaper-Mural-Plain.webp'),
              ),
            ),
            child: Column(
              children: [
               const SizedBox(
                  height: 15,
                ),
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
                      width: deviceWidth * 0.6,
                      child: customAnimatedText(
                          fontSize: deviceWidth * 0.05,
                          height: deviceHeight * 0.05,
                          width: deviceWidth,
                          text: 'اختر مدينتك',
                          context: context),
                    ),
                    Spacer(),
                  ],
                ),
                Container(
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: deviceHeight * 1.2 / deviceWidth * 0.9,
                    children: List.generate(city.cityConverter.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(25),
                          ),
                            color: Colors.black54,
                          elevation: 5,
                          shadowColor: Colors.black12,
                          child: GestureDetector(
                            onTap: () async {
                              var connectionState =
                                  await Connectivity().checkConnectivity();
                              if (connectionState == ConnectivityResult.none) {
                                Constants.get(context)
                                    .showToast('خطأ الاتصال بالانترنت');
                              }else{
                                Navigator.of(context).pushReplacementNamed(
                                  PrayTimes.routeName,
                                  arguments: CityArguments(
                                      cityArabic: city.cityConverter[index]['ar'],
                                      cityEnglish: city.cityConverter[index]
                                      ['en']),
                                );
                              }
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  '${city.cityConverter[index]['ar']}',
                                  style: TextStyle(
                                    fontSize: deviceWidth * 0.045,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    crossAxisCount: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
