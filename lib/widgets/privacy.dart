import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: () async {
          Uri url = Uri.parse('https://www.google.com.br/');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          }
        },
        child: Container(
            margin: EdgeInsets.only(bottom: screenHeight / 100),
            child: Text('Política de privacidade',
                style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 219, 219, 219)),
                    fontSize: screenWidth / 30))));
  }
}
