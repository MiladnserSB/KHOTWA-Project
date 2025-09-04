import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khotwa/controller/volunteer_controller.dart';
import 'package:khotwa/model/profile_model.dart';
import 'package:khotwa/shared/constants/colors.dart';

class ProfilePageHeader extends StatelessWidget {
  final Profile profile;
  final VolunteerController controller = Get.find();

  ProfilePageHeader({super.key, required this.profile});

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAndUploadImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(ctx);
                  final XFile? pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    await controller.uploadProfileImage(pickedFile.path);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () async {
                  Navigator.pop(ctx);
                  final XFile? pickedFile =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    await controller.uploadProfileImage(pickedFile.path);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textScale = MediaQuery.of(context).textScaleFactor;

    String imageUrl = profile.profileImageUrl.startsWith("http")
        ? profile.profileImageUrl
        : "http://your-api-domain.com${profile.profileImageUrl}";

    return Container(
      color: theme.brightness == Brightness.dark ? Colors.black : thirdColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _pickAndUploadImage(context),
            child: Obx(() {
              if (controller.isProfileLoading.value) {
                return const CircleAvatar(
                  radius: 40,
                  child: CircularProgressIndicator(),
                );
              }
              return CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(imageUrl),
                onBackgroundImageError: (_, __) {},
              );
            }),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.fullName,
                  style: TextStyle(
                    fontSize: 16 * textScale,
                    fontWeight: FontWeight.bold,
                    color: theme.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.email,
                  style: TextStyle(
                    fontSize: 13 * textScale,
                    color: theme.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
