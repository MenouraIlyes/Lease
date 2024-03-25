import 'package:flutter/material.dart';
import 'package:lease/Api_endpoint/services.dart';

import 'package:lease/models/reservation_model.dart';

// Create a provider class to hold reservation data
class ReservationProvider extends ChangeNotifier {
  // Fields to hold reservation data
  late DateTime startDate;
  late DateTime endDate;
  late String pickupTime;
  late String dropoffTime;
  late String totalPrice;
  late String vehicleId;
  late String customerId;
  late String destinationId;

  // Method to set the start date
  void setStartDate(DateTime date) {
    startDate = date;
    notifyListeners(); // Notify listeners that the data has changed
  }

  // Method to set the end date
  void setEndDate(DateTime date) {
    endDate = date;
    notifyListeners(); // Notify listeners that the data has changed
  }

  // Method to create a reservation
  Future<void> createReservation(BuildContext context) async {
    try {
      // Convert DateTime objects to strings for reservation creation
      String startDateString = startDate.toIso8601String();
      String endDateString = endDate.toIso8601String();

      // Create a Reservation object with collected data
      Reservation reservation = Reservation(
        startDate: startDateString,
        endDate: endDateString,
        pickupTime: pickupTime,
        dropoffTime: dropoffTime,
        totalPrice: totalPrice,
        vehicleId: vehicleId,
        customerId: customerId,
        destinationId: destinationId,
      );

      // Call ApiService to create the reservation
      await ApiService.createReservation(reservation);

      // Show success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Reservation created successfully.'),
      ));
    } catch (error) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to create reservation: $error'),
      ));
    }
  }
}
