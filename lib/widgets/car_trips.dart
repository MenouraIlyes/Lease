import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lease/shared/colors.dart';

class CarTrips extends StatelessWidget {
  const CarTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Trips',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: appWhite, boxShadow: [
            BoxShadow(
              color: appBlack.withOpacity(0.1),
              blurRadius: 1.0,
              spreadRadius: 1.0,
              offset: const Offset(0.0, 1.0),
            )
          ]),
        ),
      ),
    );
  }
}
