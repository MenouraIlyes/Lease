import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lease/models/booking_steps.dart';
import 'package:lease/screens/vehicles_list_screen.dart';
import 'package:lease/shared/colors.dart';
import 'package:lease/widgets/select_date_widget.dart';
import 'package:lease/widgets/select_time_widget.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  var step = BookingStep.selectTime;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
      child: Scaffold(
          backgroundColor: appWhite.withOpacity(0.5),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(FontAwesomeIcons.xmark),
            ),
            actions: const [SizedBox(width: 48.0)],
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Destination
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       step = BookingStep.selectDestination;
                  //     });
                  //   },
                  //   child: Hero(
                  //     tag: 'search',
                  //     child: SelectDestinationWidget(step: step),
                  //   ),
                  // ),

                  // Date & time
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        step = BookingStep.selectDate;
                      });
                    },
                    child: SelectDateWidget(step: step),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        step = BookingStep.selectTime;
                      });
                    },
                    child: SelectTimeWidget(step: step),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: (step == BookingStep.selectDate)
              ? null
              : Container(
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
                            if (step == BookingStep.selectDestination) {
                              setState(() {
                                step = BookingStep.selectTime;
                              });
                            } else {
                              setState(() {
                                step = BookingStep.selectDestination;
                              });
                            }
                          },
                          child: Text(
                            'Clear all',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: appRed,
                                    ),
                          ),
                        ),
                        FilledButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VehicleListScreen(),
                              ),
                            );
                          },
                          style: FilledButton.styleFrom(
                              backgroundColor: appBlue,
                              minimumSize: const Size(100, 56.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                          icon: const Icon(Icons.search),
                          label: const Text('Search'),
                        )
                      ],
                    ),
                  ),
                )),
    );
  }
}
