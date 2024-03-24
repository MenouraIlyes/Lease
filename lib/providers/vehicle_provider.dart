import 'package:flutter/material.dart';
import 'package:lease/Api_endpoint/services.dart';
import 'package:lease/models/vehicle_model.dart'; // Import your Vehicle model class

final List<Vehicle> initialData = [
  Vehicle(
    make: 'Toyota',
    model: 'Corolla',
    year: 2022,
    transmission: 'Automatic',
    seats: 5,
    doors: 4,
    mileage: '20,000 km',
    gasType: 'Petrol',
    description: 'A reliable sedan.',
    basePrice: '20000',
    photos: [
      'https://source.unsplash.com/random/?toyota',
      'https://source.unsplash.com/random/?toyota'
    ],
  ),
];

class VehicleProvider extends ChangeNotifier {
  List<Vehicle> _vehicles = []; // List to hold instances of Vehicle

  // Method to get all vehicles
  List<Vehicle> get vehicles => _vehicles;

  // Function to fetch vehicles from the backend
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

  // Method to add a new vehicle
  void addVehicle(Vehicle vehicle) {
    _vehicles.add(vehicle);
    notifyListeners(); // Notify listeners of change
  }

  // Method to remove a vehicle
  void removeVehicle(int index) {
    _vehicles.removeAt(index);
    notifyListeners(); // Notify listeners of change
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
