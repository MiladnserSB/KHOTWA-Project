import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khotwa/model/create_donation_model.dart';
import 'package:khotwa/model/my_donations_model.dart';
import '../shared/constants/base_url.dart';

class DonationService extends GetxService {
  late Dio dio;

  @override
  void onInit() {
    super.onInit();
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

    // Automatically inject token
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _getToken();
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<String> _getToken() async {
    final box = Hive.box('authBox');
    final token = box.get('token');
    return token ?? '';
  }

  /// ✅ GET /my-donations
  Future<MyDonations> getMyDonations() async {
    try {
      final response = await dio.get('/api/donatios/my-donations');
      return MyDonations.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        'Failed to load donations: ${e.response?.data ?? e.message}',
      );
    }
  }

  /// ✅ POST /donate/init
  Future<CreateDonationModel> createDonation(
    Map<String, dynamic> donationData,
  ) async {
    try {
      final response = await dio.post(
        '/api/donatios/donate/init',
        data: donationData,
      );
      return CreateDonationModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        'Failed to create donation: ${e.response?.data ?? e.message}',
      );
    }
  }

  /// ✅ POST /donate/confirm
  Future<MyDonations> confirmDonation(Map<String, dynamic> paymentData) async {
    try {
      final response = await dio.post(
        '/api/donatios/donate/confirm',
        data: paymentData,
      );
      return MyDonations.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        'Failed to confirm donation: ${e.response?.data ?? e.message}',
      );
    }
  }
}
