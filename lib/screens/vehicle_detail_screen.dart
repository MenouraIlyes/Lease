import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lease/models/vehicle_model.dart';
import 'package:lease/providers/vehicle_provider.dart';
import 'package:lease/shared/colors.dart';
import 'package:provider/provider.dart';

class VehicleDetailsScreen extends StatefulWidget {
  final Vehicle selectedVehicle; // Selected vehicle data

  const VehicleDetailsScreen({Key? key, required this.selectedVehicle})
      : super(key: key);

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  late ScrollController _scrollController; // Scrolling
  bool isFavorite = false; // Track the state of the button

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _scrollController.addListener(() {
      // Add logic to stop scrolling after a certain point
      if (_scrollController.offset > 300.0) {
        _scrollController.jumpTo(300.0);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Vehicle selectedVehicle = widget.selectedVehicle;

    var favouritesProvider = context.read<VehicleProvider>();

    // accessing favourites list
    var favourite = favouritesProvider.favourites;

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: appBlack.withOpacity(0.5),
              blurRadius: 1.0,
              spreadRadius: 1.0,
              offset: const Offset(0.0, -1.0),
            )
          ],
        ),
        child: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          notchMargin: 0,
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    // Toggle the state of the button
                    isFavorite = !isFavorite;
                  });
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: favourite.contains(selectedVehicle) ? appRed : null,
                  size: 30,
                ),
              ),
              FilledButton.icon(
                onPressed: () {},
                style: FilledButton.styleFrom(
                    backgroundColor: appBlue,
                    minimumSize: const Size(100, 56.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                label: const Text('Book now'),
                icon: const Icon(FontAwesomeIcons.bookmark),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: [
              // Display photos of the selected vehicle
              for (String photoUrl in selectedVehicle.photos)
                Image.file(
                  File(photoUrl), // Provide the correct file path here
                  width: 400, // Adjust width as needed
                  height: 400, // Adjust height as needed
                  fit: BoxFit.cover,
                ),
              Positioned(
                top: 320,
                child: Container(
                  //padding for the text and the whole container
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 700,
                  decoration: BoxDecoration(
                    color: appWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Make
                          Text(
                            selectedVehicle.make,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: appBlack.withOpacity(0.8)),
                          ),
                          // Price
                          Text(
                            '${selectedVehicle.basePrice} DA',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: appBlue),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Model
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          selectedVehicle.model,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: appBlack.withOpacity(0.8)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.locationDot,
                            color: appBlue,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Algeria, Oran",
                            style: GoogleFonts.poppins(color: appBlue),
                          )
                        ],
                      ),
                      SizedBox(height: 40),
                      Text(
                        "Description",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: appBlack.withOpacity(0.8)),
                      ),
                      SizedBox(height: 5),
                      Text(
                        selectedVehicle.description,
                        style: GoogleFonts.poppins(),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // gas-type
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.gasPump,
                                color: appBlue,
                                size: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                selectedVehicle.gasType,
                                style: GoogleFonts.poppins(color: appBlue),
                              )
                            ],
                          ),

                          // doors
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.doorOpen,
                                color: appBlue,
                                size: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                selectedVehicle.doors.toString(),
                                style: GoogleFonts.poppins(color: appBlue),
                              )
                            ],
                          ),

                          // mileage
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.road,
                                color: appBlue,
                                size: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                selectedVehicle.mileage,
                                style: GoogleFonts.poppins(color: appBlue),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Year
                          Row(
                            children: [
                              Image.asset(
                                'assets/transmission.png',
                                width: 30,
                                height: 30,
                                color: appBlue,
                              ),
                              SizedBox(width: 5),
                              Text(
                                selectedVehicle.transmission,
                                style: GoogleFonts.poppins(color: appBlue),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.calendar,
                                color: appBlue,
                                size: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                selectedVehicle.year.toString(),
                                style: GoogleFonts.poppins(color: appBlue),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      // Dates
                      Card(
                        surfaceTintColor: appWhite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 14, left: 15),
                              child: Text(
                                "Pick-up & Drop-off",
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Pick-up",
                                style: GoogleFonts.poppins(color: appBlue),
                              ),
                              subtitle: Text("10/02/2024 - 10:00 pm"),
                            ),
                            ListTile(
                              title: Text(
                                "Drop-off",
                                style: GoogleFonts.poppins(color: appBlue),
                              ),
                              subtitle: Text("15/02/2024 - 04:00 pm"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
