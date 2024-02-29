import 'dart:math';

import 'package:flutter/material.dart';
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
    return Container(
      color: appBlack,
      child: Center(
        child: Lottie.network(
            'https://lottie.host/db850b51-6a91-405a-b1e8-9c762ffd775b/yZGenGPq6R.json'),
      ),
    );
  }
}
