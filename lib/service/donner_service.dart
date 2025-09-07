import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khotwa/model/create_donation_model.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/model/my_donations_model.dart';
import 'package:khotwa/model/projects_model.dart';
import 'package:khotwa/model/top_projects_model.dart';
import '../shared/constants/base_url.dart';

class DonationService extends GetxService {
  /// ✅ Helpers
  Future<String> _getToken() async {
    final box = Hive.box('authBox');
    return box.get('token') ?? '';
  }

  Future<String> _getRoleId() async {
    final box = Hive.box('authBox');
    return box.get('role_id') ?? '';
  }

  Future<String> _getUserId() async {
    final box = Hive.box('authBox');
    return box.get('user_id') ?? '';
  }

  Future<String> _getOtp() async {
    final box = Hive.box('authBox');
    return box.get('otp') ?? '';
  }

  /// ✅ Common headers
  Future<Map<String, String>> _headers({bool withAuth = true}) async {
    final token = await _getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    if (withAuth && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer 1|BT7jbA0LJzG91mnAccUO04pOqO65eylpYOWWH0bRcb674020';
    }
    return headers;
  }

/// ✅ GET /donations/my-donations
Future<MyDonations> getMyDonations() async {
  final url = Uri.parse('$baseUrl/api/donations/my-donations');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer 1|BT7jbA0LJzG91mnAccUO04pOqO65eylpYOWWH0bRcb674020',
      "ngrok-skip-browser-warning": "true",
    },
  );

  print("Status: ${response.statusCode}");
  print("Body: ${response.body}");

  if (response.statusCode == 200) {
    return MyDonations.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load donations: ${response.body}');
  }
}


  /// ✅ POST /donations/donate/init
  Future<CreateDonationModel> createDonation(
    Map<String, dynamic> donationData,
  ) async {
    final url = Uri.parse('$baseUrl/api/donations/donate/init');
    final response = await http.post(
      url,
      headers: await _headers(),
      body: json.encode(donationData),
    );
print(response.body);
    if (response.statusCode == 200) {
      return CreateDonationModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create donation: ${response.body}');
    }
  }

  /// ✅ POST /donations/donate/confirm
  Future<MyDonations> confirmDonation(Map<String, dynamic> paymentData) async {
    final url = Uri.parse('$baseUrl/api/donatios/donate/confirm');
    final response = await http.post(
      url,
      headers: await _headers(),
      body: json.encode(paymentData),
    );
print(response.body);

    if (response.statusCode == 200) {
      return MyDonations.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to confirm donation: ${response.body}');
    }
  }

  /// ✅ GET /projects/top (public)
  Future<List<TopProject>> getTopProjects() async {
    final url = Uri.parse('$baseUrl/api/public/projects/top');
    final response = await http.get(url, headers: await _headers(withAuth: false));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == true && data['data'] is List) {
        return (data['data'] as List)
            .map((json) => TopProject.fromJson(json))
            .toList();
      } else {
        throw Exception('API returned error: ${data['message']}');
      }
    } else {
      throw Exception('Failed to load top projects: ${response.body}');
    }
  }

  /// ✅ GET /events (public)
  Future<List<EventModel>> getAllEvents() async {
    final url = Uri.parse('$baseUrl/api/public/events');
    final response = await http.get(url, headers: await _headers(withAuth: false));

    if (response.statusCode == 200) {
      final eventsModel = EventsModel.fromJson(json.decode(response.body));
      return eventsModel.data;
    } else {
      throw Exception('Failed to load all events: ${response.body}');
    }
  }

  /// ✅ GET /projects (public)
  Future<List<ProjectModel>> getAllProjects() async {
    final url = Uri.parse('$baseUrl/api/public/projects');
    final response = await http.get(url, headers: await _headers(withAuth: false));

    if (response.statusCode == 200) {
      final projectsModel = ProjectsModel.fromJson(json.decode(response.body));
      return projectsModel.data;
    } else {
      throw Exception('Failed to load all projects: ${response.body}');
    }
  }
}
