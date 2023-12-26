import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget{
  final Widget child;

  const GradientBackground({super.key, required this.child});
  
  @override
  Widget build(BuildContext context){
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 31, 79, 98),
                Color.fromARGB(255, 37, 112, 118),
                Color.fromARGB(255, 47, 150, 142)
              ],
              begin: Alignment.topCenter,
              stops: [0.1, 0.7, 1])),
      child: child
    );
  }
}