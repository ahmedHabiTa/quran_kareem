import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_kareem/Components/constants.dart';
import 'package:quran_kareem/data/city_data.dart';
import 'package:quran_kareem/presentation/screens/praying_time_table.dart';
import 'package:quran_kareem/presentation/widgets/custom_animated_text.dart';

import 'azkar_screen.dart';
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
                Container(
                  width: deviceWidth * 0.6,
                  child: customAnimatedText(
                      fontSize: deviceWidth * 0.05,
                      height: deviceHeight * 0.05,
                      width: deviceWidth,
                      text: 'اختر مدينتك',
                      context: context),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: city.cityConverter.length,
                 itemBuilder: (context,index){
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: GestureDetector(
                       onTap: ()async{
                         var connectionState =
                             await Connectivity().checkConnectivity();
                         if (connectionState == ConnectivityResult.none) {
                           Constants.get(context)
                               .showToast(msg:'خطأ الاتصال بالانترنت');
                         }else{
                           Navigator.of(context).pushNamed(
                             PrayTimes.routeName,
                             arguments: CityArguments(
                                 cityArabic: city.cityConverter[index]['ar'],
                                 cityEnglish: city.cityConverter[index]
                                 ['en']),
                           );
                         }
                       },
                       child: Container(
                         height: 50,
                         child: Card(
                           shape: RoundedRectangleBorder(
                             side: BorderSide(color: Colors.white, width: 1.0),
                             borderRadius: BorderRadius.circular(25),
                           ),
                           color: Colors.black54,
                           elevation: 5,
                           shadowColor: Colors.black12,
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
                     ),
                   );
                 },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
