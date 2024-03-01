import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.network(
            'https://lottie.host/ebd376ae-40fc-4d3e-832b-c2fd808d2bed/9cOk8PqauN.json'),
        SizedBox(height: 20),
        Text(
          "Welcome to Lease",
          style: GoogleFonts.pacifico(
              fontSize: 30, fontWeight: FontWeight.bold, color: appBlue),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "From compact cars to spacious SUVs, find the perfect ride for any occasion.",
            textAlign: TextAlign.center,
            style: GoogleFonts.kalam(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
