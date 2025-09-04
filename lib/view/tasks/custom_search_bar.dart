import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/Search_controller.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/Search/Search_results_page.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String hintText;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText = 'search',
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: size.height * 0.06,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? Colors.grey[600]!
              : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (value) {
                final searchController = Get.isRegistered<AppSearchController>()
                    ? Get.find<AppSearchController>()
                    : Get.put(AppSearchController());

                searchController.searchMyTasks(value);
              },
              onSubmitted: (value) {
                Get.to(() => SearchResultsPage());
              },
              decoration: InputDecoration(
                hintText: hintText.tr,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.black
                      ,
                ),
              ),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.clear, size: 20),
              onPressed: () {
                controller.clear();
                if (onChanged != null) onChanged!('');
              },
            ),
        ],
      ),
    );
  }
}
