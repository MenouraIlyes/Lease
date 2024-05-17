import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lease/models/reservation_model.dart';
import 'package:lease/models/user_profile_model.dart';
import 'package:lease/models/vehicle_model.dart';

class ApiService {
  static final String mainUrl = "http://192.168.1.105:3000";
  //Login Api
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final String apiUrl = '$mainUrl/login';

    final Map<String, String> data = {
      'email': email.trim(),
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
      String apiUrl = '$mainUrl/register';

      // Convert the user profile object to JSON
      String requestBody = jsonEncode(userProfile.toJson());

      // POST request to the API endpoint with JSON body
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      if (response.statusCode == 201) {
        // User registered successfully
        print('User registered successfully.');
      } else {
        // Registration failed
        print('Registration failed: ${response.body}');
      }
    } catch (error) {
      print('Error registering user: $error');
    }
  }

  // Fetch user profile by email
  static Future<UserProfile> fetchUserProfile(String email) async {
    try {
      final http.Response response = await http.get(
        Uri.parse('$mainUrl/profile/email/$email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        return UserProfile.fromJson(userData);
      } else {
        throw Exception('Failed to fetch UserProfile');
      }
    } catch (error) {
      throw Exception('Failed to fetch UserProfile: $error');
    }
  }

  // Fetch user profile by ID
  static Future<UserProfile> fetchUserProfileById(String id) async {
    try {
      final http.Response response = await http.get(
        Uri.parse('$mainUrl/profile/id/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
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

  // Fetch one vehicle by Id
  static Future<Vehicle> fetchVehicleById(String? id) async {
    final String apiUrl = '$mainUrl/vehicle/$id';

    try {
      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Vehicle vehicle = Vehicle.fromJson(responseData);
        return vehicle;
      } else if (response.statusCode == 404) {
        throw Exception('Vehicle not found');
      } else {
        throw Exception('Failed to fetch vehicle');
      }
    } catch (error) {
      throw Exception('Failed to fetch vehicle: $error');
    }
  }

  // Update vehicle Api
  static Future<void> updateVehicle(String? id, Vehicle updatedVehicle) async {
    final String url = '$mainUrl/vehicle/$id';

    try {
      final http.Response response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            updatedVehicle.toJson()), // Convert updatedVehicle to JSON
      );

      if (response.statusCode == 200) {
        // Vehicle updated successfully
        print('Vehicle updated successfully');
      } else if (response.statusCode == 404) {
        // Vehicle not found
        print('Vehicle not found. Status code: ${response.statusCode}');
      } else {
        print('Failed to update vehicle. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while updating vehicle: $e');
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
      print('Exception while deleting vehicle: $e');
    }
  }

  // Create Reservation Api
  static Future<void> createReservation(Reservation reservation) async {
    try {
      String apiUrl = '$mainUrl/reservation';

      // Convert the reservation object to a JSON string
      String requestBody = jsonEncode(reservation.toJson());

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      if (response.statusCode == 201) {
        // Reservation created successfully
        print('Reservation created successfully.');
      } else {
        // Reservation creation failed
        print('Reservation creation failed: ${response.body}');
      }
    } catch (error) {
      print('Error creating reservation: $error');
    }
  }

  // Fetch Reservation Api
  static Future<List<Reservation>> fetchReservations() async {
    try {
      String apiUrl = '$mainUrl/reservations';
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);

        // Map the JSON data to Reservation objects
        List<Reservation> reservations =
            responseData.map((data) => Reservation.fromJson(data)).toList();

        return reservations;
      } else {
        throw Exception('Failed to fetch reservations');
      }
    } catch (error) {
      throw Exception('Error fetching reservations: $error');
    }
  }

  // Delete Reservation API
  static Future<void> deleteReservation(String? reservationId) async {
    try {
      String apiUrl = '$mainUrl/reservations/$reservationId';
      var response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print('Reservation deleted successfully');
      } else if (response.statusCode == 404) {
        throw Exception('Reservation not found');
      } else {
        throw Exception('Failed to delete reservation: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error deleting reservation: $error');
    }
  }
}
