import 'package:flutter/material.dart';
import 'package:lease/shared/colors.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: appRed,
        child: Center(
          child: Lottie.network(
              'https://lottie.host/99762847-3d39-49ee-a531-ade51a35da10/QdkXeyiw9H.json'),
        ));
  }
}
