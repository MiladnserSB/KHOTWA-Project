import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../shared/constants/base_url.dart';

class DonationService extends GetxService {
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

    // Add interceptors
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
    // Implement your token retrieval logic
    return '';
  }

  Future<List<dynamic>> getMyDonations() async {
    try {
      final response = await dio.get('/api/donatios/my-donations');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw Exception('Failed to load donations: ${e.response?.statusCode}');
    }
  }

  Future<Map<String, dynamic>> createDonation(Map<String, dynamic> donationData) async {
    try {
      final response = await dio.post(
        '/api/donatios/donate/init',
        data: donationData,
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to create donation: ${e.response?.statusCode}');
    }
  }

  Future<Map<String, dynamic>> confirmDonation(int donationId, Map<String, dynamic> paymentData) async {
    try {
      final response = await dio.post(
        '/api/donatios/donate/confirm',
        data: {
          'donation_id': donationId,
          ...paymentData,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to confirm donation: ${e.response?.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getDonationStatistics() async {
    try {
      final response = await dio.get('/api/admin/donations-statistics');
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to load statistics: ${e.response?.statusCode}');
    }
  }
}