import 'package:get/get.dart';
import '../controller/supervisor_controller.dart';
import '../service/supervisor_service.dart';

class SupervisorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupervisorController());
    Get.lazyPut(() => SupervisorService());
  }
}