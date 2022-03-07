import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:quran_kareem/presentation/widgets/qiblah_compass.dart';
import 'package:quran_kareem/presentation/widgets/qiblah_maps.dart';
class CompassScreen extends StatelessWidget {
  static const routeName = '/CompassScreen' ;
  const CompassScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
    return Scaffold(
      body: FutureBuilder(
        future: _deviceSupport,
        builder: (_, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          if (snapshot.hasError)
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );

          if (snapshot.data)
            return QiblahCompass();
          else
            return QiblahMaps();
        },
      ),
    );
  }
}

