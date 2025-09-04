// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final bool status;
  final String message;
  final Profile data;

  ProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json["message"],
        data: Profile.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Profile {
  final int id;
  final int userId;
  final String status;
  final String fullName;
  final String gender;
  final String birthDate;
  final String phone;
  final String email;
  final String? city;
  final String address;
  final List<String> interests;
  final List<String> availability;
  final List<String> availabilityDays;
  final String preferredTime;
  final int volunteeringYears;
  final String motivation;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String emergencyContactRelationship;
  final String educationLevel;
  final String university;
  final DateTime registrationDate;
  final int totalVolunteerHours;
  final String profileImageUrl;
  final List<String> skills;
  final List<String> badges;
  final DateTime createdAt;
  final DateTime updatedAt;

  Profile({
    required this.id,
    required this.userId,
    required this.status,
    required this.fullName,
    required this.gender,
    required this.birthDate,
    required this.phone,
    required this.email,
    required this.city,
    required this.address,
    required this.interests,
    required this.availability,
    required this.availabilityDays,
    required this.preferredTime,
    required this.volunteeringYears,
    required this.motivation,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.emergencyContactRelationship,
    required this.educationLevel,
    required this.university,
    required this.registrationDate,
    required this.totalVolunteerHours,
    required this.profileImageUrl,
    required this.skills,
    required this.badges,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        userId: json["user_id"],
        status: json["status"],
        fullName: json["full_name"],
        gender: json["gender"],
        birthDate: json["birth_date"],
        phone: json["phone"],
        email: json["email"],
        city: json["city"],
        address: json["address"],
        interests: List<String>.from(json["interests"].map((x) => x)),
        availability: List<String>.from(json["availability"].map((x) => x)),
        availabilityDays:
            List<String>.from(json["availability_days"].map((x) => x)),
        preferredTime: json["preferred_time"],
        volunteeringYears: json["volunteering_years"],
        motivation: json["motivation"],
        emergencyContactName: json["emergency_contact_name"],
        emergencyContactPhone: json["emergency_contact_phone"],
        emergencyContactRelationship: json["emergency_contact_relationship"],
        educationLevel: json["education_level"],
        university: json["university"],
        registrationDate: DateTime.parse(json["registration_date"]),
        totalVolunteerHours: json["total_volunteer_hours"],
        profileImageUrl: json["profile_image_url"],
        skills: List<String>.from(json["skills"].map((x) => x)),
        badges: List<String>.from(json["badges"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "status": status,
        "full_name": fullName,
        "gender": gender,
        "birth_date": birthDate,
        "phone": phone,
        "email": email,
        "city": city,
        "address": address,
        "interests": List<dynamic>.from(interests.map((x) => x)),
        "availability": List<dynamic>.from(availability.map((x) => x)),
        "availability_days": List<dynamic>.from(availabilityDays.map((x) => x)),
        "preferred_time": preferredTime,
        "volunteering_years": volunteeringYears,
        "motivation": motivation,
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_phone": emergencyContactPhone,
        "emergency_contact_relationship": emergencyContactRelationship,
        "education_level": educationLevel,
        "university": university,
        "registration_date":
            "${registrationDate.year}-${registrationDate.month.toString().padLeft(2, '0')}-${registrationDate.day.toString().padLeft(2, '0')}",
        "total_volunteer_hours": totalVolunteerHours,
        "profile_image_url": profileImageUrl,
        "skills": List<dynamic>.from(skills.map((x) => x)),
        "badges": List<dynamic>.from(badges.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
