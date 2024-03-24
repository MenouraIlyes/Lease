import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lease/models/vehicle_model.dart';
import 'package:lease/providers/vehicle_provider.dart';
import 'package:lease/shared/colors.dart';
import 'package:provider/provider.dart';

class LikesCars extends StatefulWidget {
  const LikesCars({super.key});

  @override
  State<LikesCars> createState() => _LikesCarsState();
}

class _LikesCarsState extends State<LikesCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favourites',
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
