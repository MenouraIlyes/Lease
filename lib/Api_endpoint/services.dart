import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  //Login Api
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final String apiUrl = 'http://192.168.1.103:3000/login';

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
}
