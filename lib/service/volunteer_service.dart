import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../shared/constants/base_url.dart';

class VolunteerService extends GetxService {
  late Dio dio;

  @override
  void onInit() {
    super.onInit();
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _getToken();
        if (token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Future<String> _getToken() async {
    return '';
  }

  // Events
  Future<List<dynamic>> getMyEvents() async {
    try {
      final response = await dio.get('/api/volunteer/events');
      return response.data['data'] ?? [];
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

  // Tasks
  Future<List<dynamic>> getMyTasks() async {
    try {
      final response = await dio.get('/api/volunteer/tasks');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load tasks: ${e.response?.statusCode}');
    }
  }

  Future<Map<String, dynamic>> markTaskCompleted(int taskId) async {
    try {
      final response = await dio.post(
        '/api/volunteer/tasks/$taskId/completion',
        data: {'completion_state': 'completed'},
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to complete task: ${e.response?.statusCode}');
    }
  }

  // Evaluations
  Future<List<dynamic>> getMyEvaluations() async {
    try {
      final response = await dio.get('/api/volunteer/evaluations');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load evaluations: ${e.response?.statusCode}');
    }
  }

  // Feedback
  Future<Map<String, dynamic>> submitFeedback(int eventId, int rating, String comment) async {
    try {
      final response = await dio.post(
        '/api/volunteer/feedback',
        data: {
          'event_id': eventId,
          'rating': rating,
          'comment': comment,
        },
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
        data: {
          'checkin_method': 'QR',
          'qr_token': qrToken,
        },
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
        data: {
          'checkin_method': 'QR',
          'qr_token': qrToken,
        },
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
      final response = await dio.get('/api/volunteer/events/recommended');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load recommended events: ${e.response?.statusCode}');
    }
  }

  Future<List<dynamic>> getTopProjects() async {
    try {
      final response = await dio.get('/api/volunteer/projects/top');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load top projects: ${e.response?.statusCode}');
    }
  }
}