import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lease/shared/colors.dart';

class VehicleDetailsScreen extends StatefulWidget {
  const VehicleDetailsScreen({super.key});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/home1.jpg"), fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
              top: 320,
              child: Container(
                //padding for the text and the whole container
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                width: MediaQuery.of(context).size.width,
                height: 500,
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
                          "Tesla",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: appBlack.withOpacity(0.8)),
                        ),
                        Text(
                          "3000 DA",
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
                        "Model X ",
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
                      "This is the car description, here you can put all the car details such as : this is a sports car and a comfortable car for a family gathering ...etc ",
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
                              "Diesel",
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
                              "5",
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
                              "150 000 km",
                              style: GoogleFonts.poppins(color: appBlue),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton.icon(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                        backgroundColor: appRed,
                        minimumSize: const Size(50, 56.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    icon: const Icon(
                      FontAwesomeIcons.heart,
                      size: 20,
                    ),
                    label: const Text('Favorite'),
                  ),
                  SizedBox(width: 40),
                  FilledButton.icon(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                        backgroundColor: appBlue,
                        minimumSize: const Size(50, 56.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    icon: const Icon(
                      FontAwesomeIcons.circlePlus,
                      size: 20,
                    ),
                    label: const Text('Book vehicle now'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
