import 'package:get/get.dart';

class CustomSearchController extends GetxController {
  RxString interests = "".obs;
  RxString availability = "".obs;
  RxString preferredTime = "".obs;
  RxString status = "".obs;
  RxString availabilityDays = "".obs;
  RxString totalHours = "".obs;
  RxString city = "".obs;

  var volunteers = [
    {"name": "Sarah Chen", "role": "Event Coordinator", "hours": 100, "event": "2024-05-15"},
    {"name": "Michael Davis", "role": "Logistics Support", "hours": 85, "event": "2024-02-20"},
    {"name": "Maria Rodriguez", "role": "Outreach Specialist", "hours": 50, "event": "2024-03-10"},
  ].obs;
}
