import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:khotwa/model/all_volunteers_model.dart';
import 'package:khotwa/model/event_registeration_model.dart';
import '../shared/constants/base_url.dart';

class SupervisorService extends GetxService {
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
        baseUrl: baseUrl,
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
    return '13|8ZGjbRignaaOuyonnTAR3tbPQZfhDZ2anxbxXfFge2d903cb';
  }

  Future<Uint8List> generateEventQR(int eventId) async {
  try {
    final token = await _getToken();
    final response = await dio.get(
      '/api/supervisor/events/$eventId/qr',
      options: Options(
        responseType: ResponseType.bytes, // 👈 important
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    return Uint8List.fromList(response.data);
  } on DioException catch (e) {
    throw Exception('Failed to generate QR: ${e.response?.statusCode}');
  }
}


  // Attendance
  Future<List<dynamic>> getEventAttendance(int eventId) async {
    try {
      final response = await dio.get(
        '/api/supervisor/attendance/event/$eventId',
      );
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load attendance: ${e.response?.statusCode}');
    }
  }

  Future<List<dynamic>> getEventRegistrations(int eventId) async {
    try {
         final token = await _getToken();
      final response = await dio.get(
        '/api/supervisor/attendance/event/$eventId/registrations',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final data = response.data['data'] as List<dynamic>;
      return data.map((e) => EventRegistration.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(
        'Failed to load registrations: ${e.response?.statusCode}',
      );
    }
  }

Future<Map<String, dynamic>> manualCheckIn(
  int eventId,
  List<dynamic> volunteerIds,
) async {
  try {
    final token = await _getToken();
    final response = await dio.post(
      '/api/supervisor/attendance/manual',
      data: {
        'event_id': eventId,
        'volunteer_ids': volunteerIds,
        'action': 'checkin',
      },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
    );
    return response.data;
  } on DioException catch (e) {
    throw Exception(
      'Failed to check in: ${e.response?.statusCode} ${e.response?.data}',
    );
  }
}

// Manual Attendance (Check-Out)
Future<Map<String, dynamic>> manualCheckOut(
  int eventId,
  List<dynamic> volunteerIds,
) async {
  try {
    final token = await _getToken();
    final response = await dio.post(
      '/api/supervisor/attendance/manual',
      data: {
        'event_id': eventId,
        'volunteer_ids': volunteerIds,
        'action': 'checkout',
      },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
    );
    return response.data;
  } on DioException catch (e) {
    throw Exception(
      'Failed to check out: ${e.response?.statusCode} ${e.response?.data}',
    );
  }
}

  // Evaluations
  Future<Map<String, dynamic>> createEvaluation(
    Map<String, dynamic> evaluationData,
  ) async {
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

  Future<Map<String, dynamic>> updateEvaluation(
    int evaluationId,
    Map<String, dynamic> updateData,
  ) async {
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
      final response = await dio.get(
        '/api/supervisor/events/$eventId/evaluations',
      );
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load evaluations: ${e.response?.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getEvaluationById(int evaluationId) async {
    try {
      final response = await dio.get(
        '/api/supervisor/evaluations/$evaluationId',
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to load evaluation: ${e.response?.statusCode}');
    }
  }



Future<Map<String, dynamic>> createTask({
  required String title,
  required String description,
  required int volunteerId,
  required int volunteerHours,
  required String startDate,
  required String dueDate,
}) async {
  try {
    final token = await _getToken();

    final response = await dio.post(
      '/api/supervisor/tasks',
      data: {
        "title": title,
        "description": description,
        "volunteer_id": volunteerId,
        "volunteer_hours": volunteerHours,
        "start_date": startDate,
        "due_date": dueDate,
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    return response.data;
  } on DioException catch (e) {
    throw Exception(
      'Failed to create task: ${e.response?.statusCode} ${e.response?.data}',
    );
  }
}
 Future<AllVolunteersModel> getAllVolunteers() async {
    try {
      final token = await _getToken();
      final response = await dio.get(
        '/api/supervisor/volunteers',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
print("object");
      return AllVolunteersModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        'Failed to load volunteers: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }

  // Volunteer Feedback
  Future<List<dynamic>> getVolunteerFeedback(int volunteerId) async {
    try {
      final response = await dio.get(
        '/api/admin/feedback/volunteer/$volunteerId',
      );
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
      throw Exception(
        'Failed to load event feedback: ${e.response?.statusCode}',
      );
    }
  }
}
