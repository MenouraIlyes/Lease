import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lease/models/reservation_model.dart';
import 'package:lease/providers/reservation_provider.dart';
import 'package:lease/providers/user_profile_provider.dart';
import 'package:lease/providers/vehicle_provider.dart';
import 'package:lease/screens/billing_screen.dart';
import 'package:lease/shared/colors.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// Custom loading indicator widget
class CustomLoadingIndicator extends StatelessWidget {
  final String message;

  CustomLoadingIndicator({this.message = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 16.0),
            Text(
              message,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerCarTrips extends StatefulWidget {
  const CustomerCarTrips({super.key});

  @override
  State<CustomerCarTrips> createState() => _CustomerCarTrips();
}

class _CustomerCarTrips extends State<CustomerCarTrips> {
  @override
  void initState() {
    super.initState();
    Provider.of<ReservationProvider>(context, listen: false)
        .fetchReservations(context);
    Provider.of<VehicleProvider>(context, listen: false).fetchVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Your Trips",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: appWhite,
            boxShadow: [
              BoxShadow(
                color: appBlack.withOpacity(0.1),
                blurRadius: 1.0,
                spreadRadius: 1.0,
                offset: const Offset(0.0, 1.0),
              )
            ],
          ),
        ),
      ),
      body: Consumer<UserProfileProvider>(
        builder: (context, userProfileProvider, _) {
          // Access the agency username from the user profile
          final customerId = userProfileProvider.userProfile!.id;

          return Consumer<ReservationProvider>(
            builder: (context, ReservationProvider, _) {
              // Access the list of reservations
              List<Reservation> reservations = ReservationProvider.reservations;

              List<Reservation> filteredReservations = reservations
                  .where((reservation) => reservation.customerId == customerId)
                  .toList();

              // loading indicator
              if (filteredReservations.isEmpty) {
                return Center(
                  child: CustomLoadingIndicator(
                      message: 'No Trips available for you'),
                );
              }

              return Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: ListView.builder(
                  itemCount: filteredReservations.length,
                  itemBuilder: (context, index) {
                    final res = filteredReservations[index];
                    return ReservationCard(reservation: res);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ReservationCard extends StatelessWidget {
  final Reservation reservation;

  const ReservationCard({Key? key, required this.reservation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BillingScreen(reservation: reservation)),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: appWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: appBlue,
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [appWhite, appWhite],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListTile(
            title: Text(
              'Reservation ID: ${reservation.id}',
              style: GoogleFonts.poppins(
                  color: appBlue, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'Start Date: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(reservation.startDate))}',
                  style: GoogleFonts.poppins(color: appBlack),
                ),
                SizedBox(height: 10),
                Text(
                  'End Date: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(reservation.endDate))}',
                  style: GoogleFonts.poppins(color: appBlack),
                ),
                SizedBox(height: 10),
                Text(
                  'Pickup Time: ${reservation.pickupTime}',
                  style: GoogleFonts.poppins(color: appBlack),
                ),
                SizedBox(height: 10),
                Text(
                  'Dropoff Time: ${reservation.dropoffTime}',
                  style: GoogleFonts.poppins(color: appBlack),
                ),
                SizedBox(height: 10),
                Text(
                  'Total Price: ${reservation.totalPrice} DA',
                  style: GoogleFonts.poppins(color: appBlack),
                ),
                SizedBox(height: 10),
                Text(
                  'Vehicle ID: ${reservation.vehicleId}',
                  style: GoogleFonts.poppins(color: appBlack),
                ),
                SizedBox(height: 10),
                Text(
                  'Client ID: ${reservation.customerId}',
                  style: GoogleFonts.poppins(color: appBlack),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
