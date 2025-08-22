import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerSection extends StatelessWidget {
  final String title;
  final Rx<DateTime?> dateVar;

  const DatePickerSection({
    super.key,
    required this.title,
    required this.dateVar,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text(
                  dateVar.value == null
                      ? "no date selected".tr
                      : "${dateVar.value!.toLocal()}".split(' ')[0],
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),

              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C261D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    dateVar.value = picked;
                  }
                },
                child: Text("Select Date".tr,
                    style:  TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
