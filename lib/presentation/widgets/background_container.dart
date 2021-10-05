import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget widget;

  const BackgroundContainer({
    @required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: deviceHeight,
      width: deviceWidth,
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
      child: widget,
    );
  }
}
