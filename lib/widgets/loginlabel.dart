import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginLabel extends StatelessWidget {
  final String text;

  const LoginLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin:
          EdgeInsets.only(left: screenWidth / 12, bottom: screenHeight / 200),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text,
            style: GoogleFonts.lato(
                textStyle: TextStyle(
                    color: const Color.fromARGB(255, 219, 219, 219),
                    fontSize: screenWidth / 25))),
      ),
    );
  }
}
