import 'package:flutter/material.dart';
import 'package:quran_kareem/Animation/bottomAnimation.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    final deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Shimmer.fromColors(
      direction: ShimmerDirection.rtl,
      period: Duration(milliseconds: 1500),
      baseColor: Colors.transparent,
      highlightColor: Colors.white,
      enabled: true,
      child: Container(
        width: deviceWidth,
        height: deviceHeight,
        color: Colors.transparent,
        padding: EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/grad_logo.png', height: deviceHeight * 0.1),
            WidgetAnimator(
              Text(
                'جاري التحميل',
                style: TextStyle(fontSize: deviceHeight * 0.02),
              ),
            )
          ],
        )),
      ),
    );
  }
}
