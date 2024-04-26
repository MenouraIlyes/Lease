import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/Intro3.json',
            height: 300, width: 300, repeat: false),
        SizedBox(height: 20),
        Text(
          "Become a partner !",
          style: GoogleFonts.pacifico(
              fontSize: 30, fontWeight: FontWeight.bold, color: appBlue),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Join our community of partners and turn your vehicle into a money-making asset.",
            textAlign: TextAlign.center,
            style: GoogleFonts.kalam(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
