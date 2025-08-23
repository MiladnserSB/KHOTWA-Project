import 'package:get/get.dart';
import '../controller/volunteer_controller.dart';
import '../service/volunteer_service.dart';

class VolunteerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VolunteerController());
    Get.lazyPut(() => VolunteerService());
  }
}