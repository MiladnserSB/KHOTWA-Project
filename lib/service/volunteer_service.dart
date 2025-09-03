import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/model/profile_model.dart';
import 'package:khotwa/model/projects_model.dart';
import 'package:khotwa/model/tasks_model.dart';
import 'package:khotwa/model/top_projects_model.dart';
import '../shared/constants/base_url.dart';

class VolunteerService extends GetxService {
  late Dio dio;
  bool isInitialized = false;

  @override
  void onInit() {
    super.onInit();
    initializeDio();
  }

  void initializeDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://5c9e89e40ad4.ngrok-free.app',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final token = await _getToken();
            if (token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          } catch (e) {
            print('Error getting token: $e');
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          print('Dio error: ${error.message}');
          return handler.next(error);
        },
      ),
    );

    isInitialized = true;
    print('Dio initialized successfully');
  }

  Future<String> _getToken() async {
    return '11|rlOVAxsob1pHEmFLwZN87HGyZrhbGUIQVSF4gemAcc591461';
  }

 Future<List<EventModel>> getMyEvents() async {
  try {
    final token = await _getToken();
    final response = await dio.get(
      '/api/volunteer/events-registered',
      options: Options(headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }),
    );
    final eventsModel = EventsModel.fromJson(response.data);
    return eventsModel.data;
  } on DioException catch (e) {
    throw Exception('Failed to load events: ${e.response?.statusCode}');
  }
}


  Future<Map<String, dynamic>> registerForEvent(int eventId) async {
    try {
      final response = await dio.post(
        '/api/volunteer/event-register',
        data: {'event_id': eventId},
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to register: ${e.response?.statusCode}');
    }
  }

  Future<Map<String, dynamic>> withdrawFromEvent(int eventId) async {
    try {
      final response = await dio.post(
        '/api/volunteer/event-withdraw',
        data: {'event_id': eventId},
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to withdraw: ${e.response?.statusCode}');
    }
  }

  Future<List<TaskModel>> getMyTasks() async {
  try {
    final token = await _getToken();
    final response = await dio.get(
      '/api/volunteer/tasks',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final tasksModel = TasksModel.fromJson(response.data);

    if (!tasksModel.status) {
      throw Exception('Failed to load tasks: ${tasksModel.message}');
    }

    // Return the list of TaskModel
    return tasksModel.data;
  } on DioException catch (e) {
    print("Dio error: ${e.message}");
    throw Exception('Failed to load tasks: ${e.response?.statusCode}');
  } catch (e) {
    print("General error: $e");
    throw Exception('Failed to load tasks');
  }
}


  Future<List<dynamic>> getMyEvaluations() async {
    try {
      final response = await dio.get('/api/volunteer/evaluations');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load evaluations: ${e.response?.statusCode}');
    }
  }

  // Feedback
  Future<Map<String, dynamic>> submitFeedback(
    int eventId,
    int rating,
    String comment,
  ) async {
    try {
      final response = await dio.post(
        '/api/volunteer/feedback',
        data: {'event_id': eventId, 'rating': rating, 'comment': comment},
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to submit feedback: ${e.response?.statusCode}');
    }
  }

  Future<List<dynamic>> getEventFeedback(int eventId) async {
    try {
      final response = await dio.get('/api/volunteer/feedback/event/$eventId');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load feedback: ${e.response?.statusCode}');
    }
  }

  // Badges
  Future<List<dynamic>> getMyBadges() async {
    try {
      final response = await dio.get('/api/volunteer/badges');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load badges: ${e.response?.statusCode}');
    }
  }

  // Attendance
  Future<Map<String, dynamic>> checkIn(String qrToken) async {
    try {
      final response = await dio.post(
        '/api/volunteer/attendance/check-in',
        data: {'checkin_method': 'QR', 'qr_token': qrToken},
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to check in: ${e.response?.statusCode}');
    }
  }

  Future<Map<String, dynamic>> checkOut(String qrToken) async {
    try {
      final response = await dio.post(
        '/api/volunteer/attendance/check-out',
        data: {'checkin_method': 'QR', 'qr_token': qrToken},
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to check out: ${e.response?.statusCode}');
    }
  }

  // Additional features
  Future<List<dynamic>> getVolunteerLog() async {
    try {
      final response = await dio.get('/api/volunteer/events/log');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load log: ${e.response?.statusCode}');
    }
  }

  Future<List<dynamic>> getRecommendedEvents() async {
    try {
      final response = await dio.get(
        '/api/volunteer/events/recommended',

        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': '${_getToken()}',
          },
        ),
      );
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception(
        'Failed to load recommended events: ${e.response?.statusCode}',
      );
    }
  }

  Future<List<TopProject>> getTopProjects() async {
    try {
      final response = await dio.get(
        '/api/volunteer/projects/top',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': '${_getToken()}',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['status'] == true && data['data'] is List) {
          // Convert the response to proper TopProject objects
          return (data['data'] as List).map((json) {
            return TopProject.fromJson(json);
          }).toList();
        } else {
          throw Exception('API returned error: ${data['message']}');
        }
      } else {
        throw Exception('HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load top projects: ${e.message}');
    }
  }

  Future<List<EventModel>> getAllEvents() async {
    try {
      final response = await dio.get(
        '/api/volunteer/events',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': '${_getToken()}',
          },
        ),
      );
      final eventsModel = EventsModel.fromJson(response.data);
      return eventsModel.data;
    } on DioException catch (e) {
      throw Exception('Failed to load all events: ${e.response?.statusCode}');
    }
  }

  Future<List<ProjectModel>> getAllProjects() async {
    try {
      final response = await dio.get(
        '/api/volunteer/projects',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': '${_getToken()}',
          },
        ),
      );
      final projectsModel = ProjectsModel.fromJson(response.data);
      return projectsModel.data;
    } on DioException catch (e) {
      throw Exception('Failed to load all events: ${e.response?.statusCode}');
    }
  }

  Future<Map<String, dynamic>> updateTaskStatus(
    int taskId,
    String action,
  ) async {
    try {
      final response = await dio.post(
        '/api/volunteer/tasks/$taskId/status',
        data: {'action': action},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer 11|rlOVAxsob1pHEmFLwZN87HGyZrhbGUIQVSF4gemAcc591461',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(
        'Failed to update task status: ${e.response?.statusCode}',
      );
    }
  }

Future<ProfileModel> getProfile() async {
  try {
    final token = await _getToken();
    final response = await dio.get(
      '/api/volunteer/profile',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200 && response.data['status'] == true) {
      return ProfileModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load profile: ${response.data['message']}');
    }
  } on DioException catch (e) {
    throw Exception('Failed to load profile: ${e.response?.statusCode}');
  }
}


}
