import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAllVolunteersController extends GetxController {
  final volunteers = <VolunteerModel>[].obs;
  final filteredVolunteers = <VolunteerModel>[].obs;
  final isLoading = true.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchVolunteers();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void fetchVolunteers() async {
    isLoading.value = true;
    
    await Future.delayed(Duration(seconds: 2));
    
    volunteers.assignAll([
      VolunteerModel(
        name: "Sarah Chen",
        hours: "120",
        image: "https://randomuser.me/api/portraits/women/44.jpg",
        city: "Damascus",
        preferredTime: "Morning",
        availability: "Weekends"
      ),
      VolunteerModel(
        name: "Michael Davis",
        hours: "85",
        image: "https://randomuser.me/api/portraits/men/32.jpg",
        city: "Aleppo",
        preferredTime: "Evening",
        availability: "Weekdays"
      ),
      VolunteerModel(
        name: "Maria Rodriguez",
        hours: "100",
        image: "https://randomuser.me/api/portraits/women/65.jpg",
        city: "Homs",
        preferredTime: "Afternoon",
        availability: "Flexible"
      ),
      VolunteerModel(
        name: "David Lee",
        hours: "90",
        image: "https://randomuser.me/api/portraits/men/71.jpg",
        city: "Latakia",
        preferredTime: "Morning",
        availability: "Weekends"
      ),
    ]);
    
    filteredVolunteers.assignAll(volunteers);
    isLoading.value = false;
  }

  void searchVolunteers(String query) {
    if (query.isEmpty) {
      filteredVolunteers.assignAll(volunteers);
    } else {
      filteredVolunteers.assignAll(volunteers.where((volunteer) =>
          volunteer.name.toLowerCase().contains(query.toLowerCase()) ||
          volunteer.city.toLowerCase().contains(query.toLowerCase())));
    }
  }

  void applyFilters(Map<String, dynamic> filters) {
    // Filter logic will be implemented here
    filteredVolunteers.assignAll(volunteers);
  }
}

class VolunteerModel {
  final String name;
  final String hours;
  final String image;
  final String city;
  final String preferredTime;
  final String availability;

  VolunteerModel({
    required this.name,
    required this.hours,
    required this.image,
    required this.city,
    required this.preferredTime,
    required this.availability,
  });
}