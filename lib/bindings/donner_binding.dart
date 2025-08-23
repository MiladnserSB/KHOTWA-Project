import 'package:get/get.dart';
import 'package:khotwa/controller/donner_controller.dart';
import 'package:khotwa/service/donner_service.dart';

class DonorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DonorController());
    Get.lazyPut(() => DonationService());
  }
}