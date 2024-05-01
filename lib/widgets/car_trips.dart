import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lease/shared/colors.dart';
import 'package:lease/providers/reservation_provider.dart';

class CarTrips extends StatelessWidget {
  const CarTrips({Key? key});

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: ReservationProvider().fetchReservations(context),
          builder: (context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: ReservationProvider().reservations.length,
                itemBuilder: (context, index) {
                  var reservation = ReservationProvider().reservations[index];
                  return ListTile(
                    title: Text('Start Date: ${reservation.startDate}'),
                    subtitle: Text('End Date: ${reservation.endDate}'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
