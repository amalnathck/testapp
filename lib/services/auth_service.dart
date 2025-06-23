import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String apiUrl =
      'https://koolmindz.com/admin/api/v2/index.php?token=5692b9ad75db64efd3e5b623e440833d';

  static Future<Map<String, dynamic>?> logIn(
    String mobile,
    String password,
  ) async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'true') {
          final users = data['data'] as List;
          final user = users.firstWhere(
            (u) => u['mobile'] == mobile && u['password'] == password,
            orElse: () => null,
          );
          return user;
        }
      }
    } catch (e) {
      print('Login error: $e');
    }
    return null;
  }

  static Future<List<dynamic>> fetchAllUsers() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'true') {
          return data['data'];
        }
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
    return [];
  }
}
