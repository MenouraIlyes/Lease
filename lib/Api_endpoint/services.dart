import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lease/models/vehicle_model.dart';

class ApiService {
  //Login Api
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final String apiUrl = 'http://192.168.1.105:3000/login';

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
  static Future<void> registerUser(String username, String password,
      String email, String phoneNumber, String role) async {
    try {
      // Define the API endpoint URL
      String apiUrl = 'http://192.168.1.105:3000/register';

      // Create a map representing the user data
      Map<String, dynamic> userData = {
        'username': username,
        'password': password,
        'email': email,
        'phone_number': phoneNumber,
        'role': role
      };

      // Convert the user data map to a JSON string
      String requestBody = jsonEncode(userData);

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

  // Fetch Vehicles Api
  static Future<List<Vehicle>> fetchVehicles() async {
    final String apiUrl = 'http://192.168.1.105:3000/vehicle';

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
        print(response.body);
        return vehicles;
      } else {
        print(response.body);
        throw Exception('Failed to fetch vehicles');
      }
    } catch (error) {
      throw Exception('Failed to fetch vehicles: $error');
    }
  }
}
