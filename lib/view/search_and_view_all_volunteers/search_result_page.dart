
import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/search_and_view_all_volunteers/filter_dialogue.dart';

class SearchResultsPage extends StatelessWidget {
  final String searchQuery;
  
  const SearchResultsPage({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results for: $searchQuery", style: TextStyle(color: textBlack)),
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar with Filter Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search Volunteers...",
                      hintStyle: TextStyle(color: grey),
                      prefixIcon: Icon(Icons.search, color: grey),
                      filled: true,
                      fillColor: grey.withOpacity(0.1),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: grey.withOpacity(0.3)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    onSubmitted: (value) {
                      // Update search results
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: primaryColor.withOpacity(0.3)),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.filter_list, color: primaryColor),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => FilterDialog(),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Results will be shown here
            Expanded(
              child: Center(
                child: Text(
                  "Search results for: $searchQuery",
                  style: TextStyle(color: grey, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
