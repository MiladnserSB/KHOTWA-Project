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
  final int? id;
  final int? userId;
  final String? status;
  final String? fullName;
  final String? gender;
  final String? birthDate;
  final String? phone;
  final String? email;
  final String? city;
  final String? address;
  final List<String>? interests;
  final List<String>? availability;
  final List<String>? availabilityDays;
  final String? preferredTime;
  final int? volunteeringYears;
  final String? motivation;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? emergencyContactRelationship;
  final String? educationLevel;
  final String? university;
  final DateTime? registrationDate;
  final int? totalVolunteerHours;
  final String? profileImageUrl;
  final List<String>? skills;
  final List<String>? badges;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Profile({
    this.id,
    this.userId,
    this.status,
    this.fullName,
    this.gender,
    this.birthDate,
    this.phone,
    this.email,
    this.city,
    this.address,
    this.interests,
    this.availability,
    this.availabilityDays,
    this.preferredTime,
    this.volunteeringYears,
    this.motivation,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.emergencyContactRelationship,
    this.educationLevel,
    this.university,
    this.registrationDate,
    this.totalVolunteerHours,
    this.profileImageUrl,
    this.skills,
    this.badges,
    this.createdAt,
    this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"] as int?,
        userId: json["user_id"] as int?,
        status: json["status"] as String?,
        fullName: json["full_name"] as String?,
        gender: json["gender"] as String?,
        birthDate: json["birth_date"] as String?,
        phone: json["phone"] as String?,
        email: json["email"] as String?,
        city: json["city"] as String?,
        address: json["address"] as String?,
        interests: (json["interests"] as List?)?.map((x) => x.toString()).toList() ?? [],
        availability: (json["availability"] as List?)?.map((x) => x.toString()).toList() ?? [],
        availabilityDays: (json["availability_days"] as List?)?.map((x) => x.toString()).toList() ?? [],
        preferredTime: json["preferred_time"] as String?,
        volunteeringYears: json["volunteering_years"] as int?,
        motivation: json["motivation"] as String?,
        emergencyContactName: json["emergency_contact_name"] as String?,
        emergencyContactPhone: json["emergency_contact_phone"] as String?,
        emergencyContactRelationship: json["emergency_contact_relationship"] as String?,
        educationLevel: json["education_level"] as String?,
        university: json["university"] as String?,
        registrationDate: json["registration_date"] != null
            ? DateTime.tryParse(json["registration_date"])
            : null,
        totalVolunteerHours: json["total_volunteer_hours"] as int?,
        profileImageUrl: json["profile_image_url"] as String?,
        skills: (json["skills"] as List?)?.map((x) => x.toString()).toList() ?? [],
        badges: (json["badges"] as List?)?.map((x) => x.toString()).toList() ?? [],
        createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) : null,
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
        "interests": interests ?? [],
        "availability": availability ?? [],
        "availability_days": availabilityDays ?? [],
        "preferred_time": preferredTime,
        "volunteering_years": volunteeringYears,
        "motivation": motivation,
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_phone": emergencyContactPhone,
        "emergency_contact_relationship": emergencyContactRelationship,
        "education_level": educationLevel,
        "university": university,
        "registration_date": registrationDate?.toIso8601String(),
        "total_volunteer_hours": totalVolunteerHours,
        "profile_image_url": profileImageUrl,
        "skills": skills ?? [],
        "badges": badges ?? [],
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
