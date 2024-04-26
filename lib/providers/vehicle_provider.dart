import 'package:flutter/material.dart';
import 'package:lease/Api_endpoint/services.dart';
import 'package:lease/models/vehicle_model.dart';

class VehicleProvider extends ChangeNotifier {
  List<Vehicle> _vehicles = []; // List to hold instances of Vehicle

  // Method to get all vehicles
  List<Vehicle> get vehicles => _vehicles;

  Future<void> fetchVehicles() async {
    try {
      _vehicles = await ApiService.fetchVehicles();
      notifyListeners();
    } catch (error) {
      // Handle error appropriately
      // print(_vehicles);
      print('Error fetching vehicles: $error');
    }
  }

  // fetched vehicle by id
  late Vehicle _vehicle;

  Vehicle get vehicle => _vehicle;

  Future<void> fetchVehicleById(String? id) async {
    try {
      // Fetch vehicle by ID
      final Vehicle vehicle = await ApiService.fetchVehicleById(id);

      _vehicle = vehicle;

      notifyListeners();
    } catch (error) {
      print('Error fetching vehicle by ID: $error');
    }
  }

  // Likes cars
  final List<Vehicle> _favourites = [];
  // Method to ge all favourites
  List<Vehicle> get favourites => _favourites;

  // Method to add a new vehicle to favourites
  void addFavourite(Vehicle vehicle) {
    _favourites.add(vehicle);
    notifyListeners();
  }

  // Method to remove a vehicle from favourites
  void removeFavourit(Vehicle vehicle) {
    _favourites.remove(vehicle);
    notifyListeners();
  }
}
