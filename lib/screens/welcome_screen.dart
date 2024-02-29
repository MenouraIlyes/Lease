import 'package:flutter/material.dart';
import 'package:lease/intro_screens/intro_page_1.dart';
import 'package:lease/intro_screens/intro_page_2.dart';
import 'package:lease/intro_screens/intro_page_3.dart';
import 'package:lease/shared/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  //Controller to keep track of which page we're on
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        //Page view
        PageView(
          scrollDirection: Axis.vertical,
          controller: _controller,
          children: [
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
          ],
        ),

        //Dot indicators
        Container(
            alignment: Alignment(0.9, -0.7),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              axisDirection: Axis.vertical,
            ))
      ],
    ));
  }
}
