import 'package:flutter/material.dart';
import 'package:quran_kareem/presentation/screens/azkar_details_screen.dart';
import 'package:quran_kareem/presentation/widgets/custom_animated_text.dart';
import 'package:quran_kareem/presentation/widgets/custom_list_tile.dart';

import 'azkar_muslim_screen.dart';

class AzkarScreen extends StatefulWidget {
  static const routeName = 'AzkarScreen';

  @override
  _AzkarScreenState createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
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
                  text: 'لا تنسي الصلاه علي النبي',
                  context: context,
                  fontSize: deviceWidth * 0.05),
            ),
            Positioned(
              top: deviceHeight * 0.09,
              left: deviceWidth * 0.06,
              right: deviceWidth * 0.06,
              child: Container(
                height: deviceHeight*0.8,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      customListTile(
                        context: context,
                        title: 'اذكار الصباح',
                        onTap: () => Navigator.of(context).pushNamed(
                          AzkarDetailsScreen.routeName,
                          arguments:
                          'https://ahegazy.github.io/muslimKit/json/azkar_sabah.json',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customListTile(
                        context: context,
                        title: ' اذكار المساء',
                        onTap: () => Navigator.of(context).pushNamed(
                          AzkarDetailsScreen.routeName,
                          arguments:
                          'https://ahegazy.github.io/muslimKit/json/azkar_massa.json',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customListTile(
                        context: context,
                        title: ' اذكار بعد الصلاه',
                        onTap: () => Navigator.of(context).pushNamed(
                          AzkarDetailsScreen.routeName,
                          arguments:
                          'https://ahegazy.github.io/muslimKit/json/PostPrayer_azkar.json',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'أذكار النوم',
                        url: "https://www.hisnmuslim.com/api/ar/28.json",
                        title: 'أذكار النوم',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'أذكار الاستيقاظ من النوم',
                        url: "http://www.hisnmuslim.com/api/ar/1.json",
                        title: 'أذكار الاستيقاظ من النوم',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء دخول الخلاء',
                        url: "http://www.hisnmuslim.com/api/ar/6.json",
                        title: 'دعاء دخول الخلاء',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء الخروج من الخلاء',
                        url: "http://www.hisnmuslim.com/api/ar/7.json",
                        title: 'دعاء الخروج من الخلاء',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'الذكر قبل الوضوء',
                        url: "http://www.hisnmuslim.com/api/ar/8.json",
                        title: 'الذكر قبل الوضوء',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'الذكر بعد الفراغ من الوضوء',
                        url: "http://www.hisnmuslim.com/api/ar/9.json",
                        title: 'الذكر بعد الفراغ من الوضوء',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'الذكر عند دخول المنزل',
                        url: "http://www.hisnmuslim.com/api/ar/11.json",
                        title: 'الذكر عند دخول المنزل',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'الذكر عند الخروج من المنزل',
                        url: "http://www.hisnmuslim.com/api/ar/10.json",
                        title: 'الذكر عند الخروج من المنزل',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء الذهاب إلى المسجد',
                        url: "http://www.hisnmuslim.com/api/ar/12.json",
                        title: 'دعاء الذهاب إلى المسجد',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء دخول المسجد',
                        url: "http://www.hisnmuslim.com/api/ar/13.json",
                        title: 'دعاء دخول المسجد',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء الخروج من المسجد',
                        url: "http://www.hisnmuslim.com/api/ar/14.json",
                        title: 'دعاء الخروج من المسجد',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء الخروج من المسجد',
                        url: "http://www.hisnmuslim.com/api/ar/14.json",
                        title: 'دعاء الخروج من المسجد',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'أذكار الآذان',
                        url: "http://www.hisnmuslim.com/api/ar/15.json",
                        title: 'أذكار الآذان',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء ُلبْس الثوب',
                        url: "http://www.hisnmuslim.com/api/ar/2.json",
                        title: 'دعاء ُلبْس الثوب',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء الاستفتاح',
                        url: "http://www.hisnmuslim.com/api/ar/16.json",
                        title: 'دعاء الاستفتاح',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء الركوع',
                        url: "http://www.hisnmuslim.com/api/ar/17.json",
                        title: 'دعاء الركوع',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء السجود',
                        url: "http://www.hisnmuslim.com/api/ar/19.json",
                        title: 'دعاء السجود',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء الجلسة بين السجدتين',
                        url: "http://www.hisnmuslim.com/api/ar/20.json",
                        title: 'دعاء الجلسة بين السجدتين',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء سجود التلاوة',
                        url: "http://www.hisnmuslim.com/api/ar/21.json",
                        title: 'دعاء سجود التلاوة',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'الأذكار بعد السلام من الصلاة',
                        url: "http://www.hisnmuslim.com/api/ar/25.json",
                        title: 'الأذكار بعد السلام من الصلاة',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء صلاة الاستخارة',
                        url: "http://www.hisnmuslim.com/api/ar/26.json",
                        title: 'دعاء صلاة الاستخارة',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء الهم والحزن',
                        url: "http://www.hisnmuslim.com/api/ar/34.json",
                        title: 'دعاء الهم والحزن',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء من أصابه وسوسة في الإيمان',
                        url: "http://www.hisnmuslim.com/api/ar/40.json",
                        title: 'دعاء من أصابه وسوسة في الإيمان',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء الوسوسة في الصلاة و القراءة',
                        url: "http://www.hisnmuslim.com/api/ar/42.json",
                        title: 'دعاء الوسوسة في الصلاة و القراءة',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'ما يقول ويفعل من أذنب ذنبا',
                        url: "http://www.hisnmuslim.com/api/ar/44.json",
                        title: 'ما يقول ويفعل من أذنب ذنبا',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء طرد الشيطان و وساوسه',
                        url: "http://www.hisnmuslim.com/api/ar/45.json",
                        title: 'دعاء طرد الشيطان و وساوسه',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء من أصيب بمصيبة',
                        url: "http://www.hisnmuslim.com/api/ar/53.json",
                        title: 'دعاء من أصيب بمصيبة',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'الدعاء إذا نزل المطر',
                        url: "http://www.hisnmuslim.com/api/ar/64.json",
                        title: 'الدعاء إذا نزل المطر',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'الذكر بعد نزول المطر',
                        url: "http://www.hisnmuslim.com/api/ar/65.json",
                        title: 'الذكر بعد نزول المطر',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'ما يعصم الله به من الدجال',
                        url: "http://www.hisnmuslim.com/api/ar/88.json",
                        title: 'ما يعصم الله به من الدجال',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء الخوف من الشرك',
                        url: "http://www.hisnmuslim.com/api/ar/92.json",
                        title: 'دعاء الخوف من الشرك',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'دعاء السفر',
                        url: "http://www.hisnmuslim.com/api/ar/96.json",
                        title: 'دعاء السفر',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'فضل الصلاة على النبي صلى الله عليه و سلم',
                        url: "http://www.hisnmuslim.com/api/ar/107.json",
                        title: 'فضل الصلاة على النبي ',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'إفشاء السلام',
                        url: "http://www.hisnmuslim.com/api/ar/108.json",
                        title: 'إفشاء السلام',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'كيف يرد السلام على الكافر إذا سلم',
                        url: "http://www.hisnmuslim.com/api/ar/109.json",
                        title: 'كيف يرد السلام على الكافر إذا سلم',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customAzkarDetails(
                        detailsUrl: 'كيف كان النبي يسبح؟',
                        url: "http://www.hisnmuslim.com/api/ar/131.json",
                        title: 'كيف كان النبي يسبح؟',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
    );
  }

  Widget customAzkarDetails({

    @required String url,
    @required String title,
    @required String detailsUrl,
  }) {
    return customListTile(
      context: context,
      title: title,
      onTap: () => Navigator.of(context).pushNamed(
        AzkarMuslimDetailsScreen.routeName,
        arguments: {
          'url': url,
          'title': title,
          'detailsUrl': detailsUrl,
        },
      ),
    );
  }
}
