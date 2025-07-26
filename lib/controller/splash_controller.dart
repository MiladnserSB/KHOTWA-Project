import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:khotwa/shared/constants/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    checkIfThereIsToken();
  }

  void checkIfThereIsToken() async {
    await Future.delayed(const Duration(seconds: 3));
    final box = Hive.box('authBox');
    final token = box.get('token');

    if (token != null) {
      Get.offAllNamed(AppRoutes.homeVolunteer);
    } else {
      Get.offAllNamed(AppRoutes.intro);
    }
  }
}
