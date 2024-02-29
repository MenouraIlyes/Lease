import 'package:flutter/material.dart';
import 'package:lease/shared/colors.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: appBlue,
        child: Center(
          child: Lottie.network(
              'https://lottie.host/ebd376ae-40fc-4d3e-832b-c2fd808d2bed/9cOk8PqauN.json'),
        ));
  }
}
