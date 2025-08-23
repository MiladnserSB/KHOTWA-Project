import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../shared/constants/base_url.dart';

class SupervisorService extends GetxService {
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

  // QR Generation
  Future<Map<String, dynamic>> generateEventQR(int eventId) async {
    try {
      final response = await dio.get('/api/supervisor/events/$eventId/qr');
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to generate QR: ${e.response?.statusCode}');
    }
  }

  // Attendance
  Future<List<dynamic>> getEventAttendance(int eventId) async {
    try {
      final response = await dio.get('/api/supervisor/attendance/event/$eventId');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load attendance: ${e.response?.statusCode}');
    }
  }

  Future<List<dynamic>> getEventRegistrations(int eventId) async {
    try {
      final response = await dio.get('/api/supervisor/attendance/event/$eventId/registrations');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load registrations: ${e.response?.statusCode}');
    }
  }

  Future<Map<String, dynamic>> manualCheckIn(int eventId, List<int> volunteerIds) async {
    try {
      final response = await dio.post(
        '/api/supervisor/attendance/manual',
        data: {
          'event_id': eventId,
          'volunteer_ids': volunteerIds,
          'action': 'checkin',
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to check in: ${e.response?.statusCode}');
    }
  }

  Future<Map<String, dynamic>> manualCheckOut(int eventId, List<int> volunteerIds) async {
    try {
      final response = await dio.post(
        '/api/supervisor/attendance/manual',
        data: {
          'event_id': eventId,
          'volunteer_ids': volunteerIds,
          'action': 'checkout',
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to check out: ${e.response?.statusCode}');
    }
  }

  // Evaluations
  Future<Map<String, dynamic>> createEvaluation(Map<String, dynamic> evaluationData) async {
    try {
      final response = await dio.post(
        '/api/supervisor/evaluations',
        data: evaluationData,
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to create evaluation: ${e.response?.statusCode}');
    }
  }

  Future<Map<String, dynamic>> updateEvaluation(int evaluationId, Map<String, dynamic> updateData) async {
    try {
      final response = await dio.put(
        '/api/supervisor/evaluations/$evaluationId',
        data: updateData,
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to update evaluation: ${e.response?.statusCode}');
    }
  }

  Future<List<dynamic>> getEventEvaluations(int eventId) async {
    try {
      final response = await dio.get('/api/supervisor/events/$eventId/evaluations');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load evaluations: ${e.response?.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getEvaluationById(int evaluationId) async {
    try {
      final response = await dio.get('/api/supervisor/evaluations/$evaluationId');
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to load evaluation: ${e.response?.statusCode}');
    }
  }

  // Tasks
  Future<Map<String, dynamic>> createTask(Map<String, dynamic> taskData) async {
    try {
      final response = await dio.post(
        '/api/supervisor/tasks',
        data: taskData,
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to create task: ${e.response?.statusCode}');
    }
  }

  // Volunteer Feedback
  Future<List<dynamic>> getVolunteerFeedback(int volunteerId) async {
    try {
      final response = await dio.get('/api/admin/feedback/volunteer/$volunteerId');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load feedback: ${e.response?.statusCode}');
    }
  }

  Future<List<dynamic>> getEventFeedbackByVolunteer(int eventId) async {
    try {
      final response = await dio.get('/api/admin/events/$eventId/feedback');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load event feedback: ${e.response?.statusCode}');
    }
  }
}