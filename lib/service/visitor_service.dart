import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/model/projects_model.dart';
import 'package:khotwa/model/top_projects_model.dart';
import '../shared/constants/base_url.dart';

class VisitorService extends GetxService {
  late http.Client client;
  bool isInitialized = false;

  @override
  void onInit() {
    super.onInit();
    initializeHttp();
  }

  void initializeHttp() {
    client = http.Client();
    isInitialized = true;
    print('HTTP client initialized successfully');
  }

  Future<List<TopProject>> getTopProjects() async {
    print("object1");
    final url = Uri.parse('$baseUrl/api/public/projects/top');
    final response = await client.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
print("object2");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == true && data['data'] is List) {
        return (data['data'] as List)
            .map((json) => TopProject.fromJson(json))
            .toList();
      } else {
        throw Exception('API returned error: ${data['message']}');
      }
    } else {
      throw Exception('HTTP ${response.statusCode}');
    }
  }

  Future<List<EventModel>> getAllEvents() async {
    final url = Uri.parse('$baseUrl/api/public/events');
    final response = await client.get(url, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final eventsModel = EventsModel.fromJson(data);
      return eventsModel.data;
    } else {
      throw Exception('Failed to load all events: ${response.statusCode}');
    }
  }

  Future<List<ProjectModel>> getAllProjects() async {
    final url = Uri.parse('$baseUrl/api/public/projects');
    final response = await client.get(url, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final projectsModel = ProjectsModel.fromJson(data);
      return projectsModel.data;
    } else {
      throw Exception('Failed to load all projects: ${response.statusCode}');
    }
  }
}
