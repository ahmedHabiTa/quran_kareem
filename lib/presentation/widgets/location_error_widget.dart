import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocationErrorWidget extends StatelessWidget {
  final String error;
  final Function callback;

  const LocationErrorWidget({Key key, this.error, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = SizedBox(height: 32);

    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset('assets/images/undraw_traveling_re_weve.svg'),
            box,
            Text(
              error,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            box,
            ElevatedButton(
              child: Text("Retry"),
              onPressed: () {
                if (callback != null) callback();
              },
            )
          ],
        ),
      ),
    );
  }
}
