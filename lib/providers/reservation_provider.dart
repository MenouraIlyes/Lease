import 'package:flutter/material.dart';
import 'package:lease/Api_endpoint/services.dart';

import 'package:lease/models/reservation_model.dart';

// Create a provider class to hold reservation data
class ReservationProvider extends ChangeNotifier {
  late List<Reservation> reservations = [];
  // Fields to hold reservation data
  late DateTime startDate;
  late DateTime endDate;
  late String pickupTime;
  late String dropoffTime;
  late String totalPrice;
  late String vehicleId;
  late String customerId;

  void setStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
    print(startDate);
  }

  void setEndDate(DateTime date) {
    endDate = date;
    notifyListeners();
    print(endDate);
  }

  void setPickupTime(String time) {
    pickupTime = time;
    notifyListeners();
    print(pickupTime);
  }

  void setDropoffTime(String time) {
    dropoffTime = time;
    notifyListeners();
    print(dropoffTime);
  }

  void setVehicleId(String id) {
    vehicleId = id;
    notifyListeners();
  }

  void setTotalPrice(String price) {
    totalPrice = price;
    notifyListeners();
  }

  void setCustomerId(String id) {
    customerId = id;
    notifyListeners();
  }

  // Method to create a reservation
  Future<void> createReservation(BuildContext context) async {
    try {
      // Convert DateTime objects to strings for reservation creation
      String startDateString = startDate.toIso8601String();
      String endDateString = endDate.toIso8601String();

      Reservation reservation = Reservation(
        startDate: startDateString,
        endDate: endDateString,
        pickupTime: pickupTime,
        dropoffTime: dropoffTime,
        totalPrice: totalPrice,
        vehicleId: vehicleId,
        customerId: customerId,
      );

      // Call ApiService to create the reservation
      await ApiService.createReservation(reservation);
    } catch (error) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to create reservation: $error'),
      ));
    }
  }

  // Method to fetch reservations
  Future<void> fetchReservations(BuildContext context) async {
    try {
      List<Reservation> fetchedReservations =
          await ApiService.fetchReservations();

      reservations = fetchedReservations;

      notifyListeners();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to fetch reservations: $error'),
      ));
    }
  }

  // Method to delete a reservation
  // Future<void> deleteReservation(String vehicleId) async {
  //   try {
  //     List<Reservation> reservations = await ApiService.fetchReservations();

  //     for (Reservation reservation in reservations) {
  //       if (reservation.vehicleId == vehicleId) {
  //         await ApiService.deleteReservation(reservation.id!);
  //         await ApiService.fetchReservations();
  //       }
  //     }
  //   } catch (error) {
  //     throw Exception('Error deleting reservation: $error');
  //   }
  // }
}
