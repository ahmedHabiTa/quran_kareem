import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  final String title;

  final String routeName;

  const CustomCard({
   @required this.title,
    @required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Material(
        borderRadius: BorderRadius.circular(25),
        color: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.grey[900],
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushReplacementNamed(routeName),
          child: Container(
            width: deviceWidth * 0.7,
            height: deviceHeight * 0.06,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: Colors.black45),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.lobster(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: deviceHeight * 0.025),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
