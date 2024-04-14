import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lease/models/reservation_model.dart';
import 'package:lease/models/user_profile_model.dart';
import 'package:lease/models/vehicle_model.dart';

class ApiService {
  static final String mainUrl = "http://192.168.1.107:3000";
  //Login Api
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final String apiUrl = '$mainUrl/login';

    final Map<String, String> data = {
      'username': email.trim(),
      'password': password.trim(),
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  //Register Api
  static Future<void> registerUser(UserProfile userProfile) async {
    try {
      // Define the API endpoint URL
      String apiUrl = '$mainUrl/register';

      // Convert the user profile object to JSON
      String requestBody = jsonEncode(userProfile.toJson());

      // Make a POST request to the API endpoint with JSON body
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json'
        }, // Set content-type header
        body: requestBody,
      );

      // Check if the request was successful (status code 201)
      if (response.statusCode == 201) {
        // User registered successfully
        print('User registered successfully.');
        // You can navigate to another screen or show a success message here
      } else {
        // Registration failed, print the error message
        print('Registration failed: ${response.body}');
        // You can display an error message to the user here
      }
    } catch (error) {
      // Error occurred during registration process
      print('Error registering user: $error');
      // You can display an error message to the user here
    }
  }

  // Fetch user profile by username
  static Future<UserProfile> fetchUserProfile(String username) async {
    try {
      final http.Response response = await http.get(
        Uri.parse('$mainUrl/profile/$username'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // If the server returns a successful response, parse the JSON
        final Map<String, dynamic> userData = json.decode(response.body);
        return UserProfile.fromJson(userData);
      } else {
        throw Exception('Failed to fetch UserProfile');
      }
    } catch (error) {
      throw Exception('Failed to fetch UserProfile: $error');
    }
  }

  // Post Vehciles Api
  static Future<void> postVehicle(Vehicle vehicle) async {
    final String url = '$mainUrl/vehicle';

    // Convert Vehicle object to JSON
    final Map<String, dynamic> vehicleData = vehicle.toJson();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(vehicleData),
      );

      if (response.statusCode == 200) {
        // Vehicle posted successfully
        print('Vehicle posted successfully');
      } else {
        // Error posting vehicle
        print('Failed to post vehicle. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      print('Exception while posting vehicle: $e');
    }
  }

  // Fetch Vehicles Api
  static Future<List<Vehicle>> fetchVehicles() async {
    final String apiUrl = '$mainUrl/vehicle';

    try {
      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<Vehicle> vehicles = responseData
            .map((vehicleData) => Vehicle.fromJson(vehicleData))
            .toList();
        return vehicles;
      } else {
        throw Exception('Failed to fetch vehicles');
      }
    } catch (error) {
      throw Exception('Failed to fetch vehicles: $error');
    }
  }

  // Delete vehicle Api
  static Future<void> deleteVehicle(String? id) async {
    final String url = '$mainUrl/vehicle/$id';

    try {
      final http.Response response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Vehicle deleted successfully
        print('Vehicle deleted successfully');
      } else if (response.statusCode == 404) {
        // Vehicle not found
        print('Vehicle not found. Status code: ${response.statusCode}');
      } else {
        // Error deleting vehicle
        print('Failed to delete vehicle. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      print('Exception while deleting vehicle: $e');
    }
  }

  // Create Reservation Api
  static Future<void> createReservation(Reservation reservation) async {
    try {
      // Define the API endpoint URL
      String apiUrl = '$mainUrl/reservation';

      // Convert the reservation object to a JSON string
      String requestBody = jsonEncode(reservation.toJson());

      // Make a POST request to the API endpoint with JSON body
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      // Check if the request was successful (status code 201)
      if (response.statusCode == 201) {
        // Reservation created successfully
        print('Reservation created successfully.');
        // You can navigate to another screen or show a success message here
      } else {
        // Reservation creation failed, print the error message
        print('Reservation creation failed: ${response.body}');
        // You can display an error message to the user here
      }
    } catch (error) {
      // Error occurred during reservation creation process
      print('Error creating reservation: $error');
      // You can display an error message to the user here
    }
  }
}
