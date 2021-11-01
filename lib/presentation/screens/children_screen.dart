import 'package:flutter/material.dart';
import 'package:quran_kareem/presentation/screens/web_view_details.dart';

class ChildrenScreen extends StatelessWidget {
  static const routeName = '/ChildrenScreen';

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            children: [
              customGridViewItem(
                  context: context,
                  imagePath: 'assets/images/childwash.jpg',
                  routeName: WebViewDetails.routeName,
                  videoLink: 'https://youtu.be/y3Hd5srW_ak'),
              customGridViewItem(
                  context: context,
                  imagePath: 'assets/images/childpray.jpg',
                  routeName: WebViewDetails.routeName,
                  videoLink: 'https://youtu.be/edL3W38ODd4'),
              customGridViewItem(
                  context: context,
                  imagePath: 'assets/images/fatiha.jpg',
                  routeName: WebViewDetails.routeName,
                  videoLink: 'https://youtu.be/MPCvPqIeCCs'),
              customGridViewItem(
                  context: context,
                  imagePath: 'assets/images/arkaneslam.jpg',
                  routeName: WebViewDetails.routeName,
                  videoLink: 'https://youtu.be/vC43yxyjIEE'),
              customGridViewItem(
                  context: context,
                  imagePath: 'assets/images/berwalden.jpg',
                  routeName: WebViewDetails.routeName,
                  videoLink: 'https://youtu.be/kdD1k4OHEcI'),
              customGridViewItem(
                  context: context,
                  imagePath: 'assets/images/maghreb.jpg',
                  routeName: WebViewDetails.routeName,
                  videoLink: 'https://youtu.be/gXhxa7QjEEM'),
              customGridViewItem(
                  context: context,
                  imagePath: 'assets/images/aisha.jpg',
                  routeName: WebViewDetails.routeName,
                  videoLink: 'https://youtu.be/NW4Le9Z-5Mo'),
              customGridViewItem(
                  context: context,
                  imagePath: 'assets/images/duhr.jpg',
                  routeName: WebViewDetails.routeName,
                  videoLink: 'https://youtu.be/L2F_myEd8ag'),
            ],
          ),
        ),
      ),
    );
  }


  Widget customGridViewItem({
    BuildContext context,
    String routeName,
    String imagePath,
    String videoLink,
  }) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, routeName, arguments: videoLink),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(imagePath),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
