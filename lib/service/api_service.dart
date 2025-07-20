// services/api_service.dart


class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

//
  // Future<bool> login(User user) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/login'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode(user.toJson()),
  //   );

  //   if (response.statusCode == 200) {
  //     // Assuming a successful login returns a token or user data
  //     return true; // You can return user data or token here if needed
  //   } else {
  //     return false; // Handle different status codes as needed
  //   }
  // }
}
