import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lease/shared/colors.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Lottie.asset('assets/Intro2.json',
          height: 300, width: 300, repeat: false),
      SizedBox(height: 20),
      Text(
        "Seamless booking process",
        style: GoogleFonts.pacifico(
            fontSize: 30, fontWeight: FontWeight.bold, color: appBlue),
      ),
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "Unlock a world of possibilities with our easy-to-use car rental platform",
          textAlign: TextAlign.center,
          style: GoogleFonts.kalam(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      )
    ]);
  }
}
