import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';

class ProfileCategoryDetails extends StatefulWidget {
  final String title;
  final List<Map<String, String>> fields;

  const ProfileCategoryDetails({
    Key? key,
    required this.title,
    required this.fields,
  }) : super(key: key);

  @override
  State<ProfileCategoryDetails> createState() => _ProfileCategoryDetailsState();
}

class _ProfileCategoryDetailsState extends State<ProfileCategoryDetails> {
  late final List<TextEditingController> controllers;
  bool isEditing = false;
  final Map<String, String> updatedData = {};

  @override
  void initState() {
    super.initState();
    controllers = widget.fields
        .map((item) => TextEditingController(text: item['value'] ?? ''))
        .toList();
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void changeEditSaveState() {
    if (isEditing) {
      updatedData.clear();
      for (int i = 0; i < widget.fields.length; i++) {
        final label = widget.fields[i]['label'] ?? 'field_$i';
        updatedData[label] = controllers[i].text;
      }

      Get.snackbar(
        'Profile saved'.tr,
        'Success'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }

    setState(() => isEditing = !isEditing);
  }

  @override
  Widget build(BuildContext context) {

    final textScale = MediaQuery.of(context).textScaleFactor;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : thirdColor,
      appBar: AppBar(
        title: Text(
          widget.title,
          style:  TextStyle(
            color:   theme.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:   theme.brightness == Brightness.dark
                        ? primaryColor
                        : secondaryColor,
        elevation: 2,
        leading:  BackButton(color:   theme.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
          child: ListView.builder(
            itemCount: widget.fields.length,
            itemBuilder: (context, index) {
              final label = widget.fields[index]['label'] ?? '';
              return AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? thirdColor : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16 * textScale,
                        color:   theme.brightness == Brightness.dark
                        ? primaryColor
                        : secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: SizeTransition(
                          sizeFactor: anim,
                          axisAlignment: -1,
                          child: child,
                        ),
                      ),
                      child: isEditing
                          ? TextField(
                              key: ValueKey('edit_$index'),
                              controller: controllers[index],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14 * textScale,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: thirdColor.withOpacity(0.9),
                                prefixIcon: Icon(Icons.edit, color: primaryColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: primaryColor.withOpacity(0.6),
                                      width: 1.3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 1.8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 14,
                                ),
                              ),
                            )
                          : Container(
                              key: ValueKey('view_$index'),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                controllers[index].text,
                                style: TextStyle(
                                  fontSize: 14* textScale,  
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: changeEditSaveState,
        backgroundColor:  theme.brightness == Brightness.dark
                        ?primaryColor
                        : secondaryColor,
        label: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Text(
            isEditing ? 'Save'.tr : 'Edit'.tr,
            key: ValueKey(isEditing),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Icon(
            isEditing ? Icons.save_rounded : Icons.edit_rounded,
            key: ValueKey(isEditing),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
