import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lease/models/reservation_model.dart';
import 'package:lease/models/vehicle_model.dart';
import 'package:lease/providers/reservation_provider.dart';
import 'package:lease/providers/user_profile_provider.dart';
import 'package:lease/providers/vehicle_provider.dart';
import 'package:lease/shared/colors.dart';
import 'package:provider/provider.dart';

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

class CarTrips extends StatefulWidget {
  const CarTrips({super.key});

  @override
  State<CarTrips> createState() => _CarTripsState();
}

class _CarTripsState extends State<CarTrips> {
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
          final agencyUsername = userProfileProvider.userProfile!.username;

          return Consumer<ReservationProvider>(
            builder: (context, ReservationProvider, _) {
              // Access the list of reservations
              List<Reservation> reservations = ReservationProvider.reservations;

              List<Reservation> filteredReservations =
                  reservations.where((reservation) {
                String vehicleId = reservation.vehicleId;
                String extractedAgencyName =
                    extractAgencyNameFromVehicleId(vehicleId, context);

                return extractedAgencyName == agencyUsername;
              }).toList();

              // loading indicator
              if (filteredReservations.isEmpty) {
                return Center(
                  child: CustomLoadingIndicator(
                      message: 'No Trips available for your agency'),
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

  String extractAgencyNameFromVehicleId(
      String vehicleId, BuildContext context) {
    // Find the vehicle model with the given vehicle ID
    Vehicle? vehicle = Provider.of<VehicleProvider>(context, listen: false)
        .vehicles
        .firstWhere((vehicle) => vehicle.id == vehicleId);

    return vehicle.agencyName ?? '';
  }
}

class ReservationCard extends StatelessWidget {
  final Reservation reservation;

  const ReservationCard({Key? key, required this.reservation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Reservation ID: ${reservation.id}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Start Date: ${reservation.startDate}'),
          Text('End Date: ${reservation.endDate}'),
          Text('Pickup Time: ${reservation.pickupTime}'),
          Text('Dropoff Time: ${reservation.dropoffTime}'),
          Text('Total Price: ${reservation.totalPrice}'),
          Text('Vehicle ID: ${reservation.vehicleId}'),
          Text('Customer ID: ${reservation.customerId}'),
        ],
      ),
    );
  }
}
