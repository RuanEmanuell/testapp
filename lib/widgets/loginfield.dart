import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final TextEditingController textController;
  final dynamic inputFormatter;
  final bool obscureText;
  final IconData icon;

  LoginField({super.key, required this.textController, required this.inputFormatter, required this.obscureText, required this.icon});
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
             margin: EdgeInsets.only(
              left: screenWidth / 15,
              right: screenWidth / 15,
              bottom: screenHeight / 33),
              child: TextFormField(
                       controller: textController,
                       maxLength: 20,
                          obscureText: obscureText,
                          inputFormatters: [
                            inputFormatter
                          ],
                          decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              prefixIcon: Icon(icon))));
  }
}
