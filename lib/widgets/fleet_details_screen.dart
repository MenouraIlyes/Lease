import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lease/Api_endpoint/services.dart';
import 'package:lease/models/reservation_model.dart';
import 'package:lease/models/vehicle_model.dart';
import 'package:lease/providers/reservation_provider.dart';
import 'package:lease/screens/update_vehicle.dart';
import 'package:lease/shared/colors.dart';
import 'package:lease/shared/confirmation_dialogue.dart';
import 'package:provider/provider.dart';

class FleetDetailsScreen extends StatefulWidget {
  final Vehicle selectedVehicle;

  const FleetDetailsScreen({Key? key, required this.selectedVehicle})
      : super(key: key);

  @override
  State<FleetDetailsScreen> createState() => _FleetDetailsScreenState();
}

class _FleetDetailsScreenState extends State<FleetDetailsScreen> {
  late ScrollController _scrollController; // Scrolling
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    Provider.of<ReservationProvider>(context, listen: false)
        .fetchReservations(context);
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _scrollController.addListener(() {
      // Add logic to stop scrolling after a certain point
      if (_scrollController.offset > 150.0) {
        _scrollController.jumpTo(150.0);
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

    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: [
              // Display photos of the selected vehicle
              Image.network(
                selectedVehicle.photos.first,
                width: 400,
                height: 400,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 320,
                child: Container(
                  //padding for the text and the whole container
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  width: MediaQuery.of(context).size.width,
                  //Size of the container
                  height: 900,
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
                                '${selectedVehicle.mileage} Km',
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
                          // Transmission
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
                          // Year
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

                      // Modify vehicle button
                      Padding(
                        padding: const EdgeInsets.only(left: 40, top: 20),
                        child: FilledButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateVehicleScreen(
                                      vehicle: selectedVehicle)),
                            );
                          },
                          style: FilledButton.styleFrom(
                              backgroundColor: appBlue,
                              minimumSize: const Size(100, 56.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                          label: const Text('Change Vehicle Informations'),
                          icon: const Icon(FontAwesomeIcons.penToSquare),
                        ),
                      ),

                      // Delete vehicle button
                      Padding(
                        padding: const EdgeInsets.only(left: 40, top: 20),
                        child: FilledButton.icon(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return ConfirmationDialog(
                                    onConfirm: () async {
                                      try {
                                        await ApiService.deleteVehicle(
                                            selectedVehicle.id);

                                        List<Reservation> reservations =
                                            Provider.of<ReservationProvider>(
                                                    context,
                                                    listen: false)
                                                .reservations;

                                        Reservation? matchingReservation;
                                        for (var reservation in reservations) {
                                          if (reservation.vehicleId ==
                                              selectedVehicle.id) {
                                            matchingReservation = reservation;
                                            break;
                                          }
                                        }

                                        if (matchingReservation != null) {
                                          await ApiService.deleteReservation(
                                              matchingReservation.id);
                                        }

                                        context.go('/home');
                                      } catch (error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'Failed to delete vehicle: $error'),
                                        ));
                                      }
                                    },
                                  );
                                });
                          },
                          style: FilledButton.styleFrom(
                              backgroundColor: appRed,
                              minimumSize: const Size(100, 56.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                          label: const Text(
                              '              Delete Vehicle             '),
                          icon: const Icon(FontAwesomeIcons.trash,
                              color: appWhite),
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
