// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

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
    final String status;
    final String fullName;
    final String email;
    final String phone;
    final dynamic cityId;
    final String educationLevel;
    final String university;
    final DateTime registrationDate;
    final int totalVolunteerHours;
    final String profileImageUrl;
    final List<String> skills;
    final List<String> badges;

    Profile({
        required this.id,
        required this.status,
        required this.fullName,
        required this.email,
        required this.phone,
        required this.cityId,
        required this.educationLevel,
        required this.university,
        required this.registrationDate,
        required this.totalVolunteerHours,
        required this.profileImageUrl,
        required this.skills,
        required this.badges,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        status: json["status"],
        fullName: json["full_name"],
        email: json["email"],
        phone: json["phone"],
        cityId: json["city_id"],
        educationLevel: json["education_level"],
        university: json["university"],
        registrationDate: DateTime.parse(json["registration_date"]),
        totalVolunteerHours: json["total_volunteer_hours"],
        profileImageUrl: json["profile_image_url"],
        skills: List<String>.from(json["skills"].map((x) => x)),
        badges: List<String>.from(json["badges"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "full_name": fullName,
        "email": email,
        "phone": phone,
        "city_id": cityId,
        "education_level": educationLevel,
        "university": university,
        "registration_date": "${registrationDate.year.toString().padLeft(4, '0')}-${registrationDate.month.toString().padLeft(2, '0')}-${registrationDate.day.toString().padLeft(2, '0')}",
        "total_volunteer_hours": totalVolunteerHours,
        "profile_image_url": profileImageUrl,
        "skills": List<dynamic>.from(skills.map((x) => x)),
        "badges": List<dynamic>.from(badges.map((x) => x)),
    };
}
