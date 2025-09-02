// To parse this JSON data, do
//
//     final projectsModel = projectsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProjectsModel projectsModelFromJson(String str) => ProjectsModel.fromJson(json.decode(str));

String projectsModelToJson(ProjectsModel data) => json.encode(data.toJson());

class ProjectsModel {
    final bool status;
    final String message;
    final List<ProjectModel> data;

    ProjectsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory ProjectsModel.fromJson(Map<String, dynamic> json) => ProjectsModel(
        status: json["status"],
        message: json["message"],
        data: List<ProjectModel>.from(json["data"].map((x) => ProjectModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ProjectModel {
    final int id;
    final String name;
    final String description;
    final DateTime startDate;
    final DateTime endDate;
    final Status status;
    final dynamic coverImage;
    final int targetDonation;
    final int donatedAmount;
    final int remainingAmount;
    final int totalDonations;
    final int totalVolunteers;
    final int totalEvents;
    final DateTime createdAt;
    final DateTime updatedAt;

    ProjectModel({
        required this.id,
        required this.name,
        required this.description,
        required this.startDate,
        required this.endDate,
        required this.status,
        required this.coverImage,
        required this.targetDonation,
        required this.donatedAmount,
        required this.remainingAmount,
        required this.totalDonations,
        required this.totalVolunteers,
        required this.totalEvents,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json["id"],
        name: json["name"]!,
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        status: statusValues.map[json["status"]]!,
        coverImage: json["cover_image"],
        targetDonation: json["target_donation"],
        donatedAmount: json["donated_amount"],
        remainingAmount: json["remaining_amount"],
        totalDonations: json["total_donations"],
        totalVolunteers: json["total_volunteers"],
        totalEvents: json["total_events"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "status": statusValues.reverse[status],
        "cover_image": coverImage,
        "target_donation": targetDonation,
        "donated_amount": donatedAmount,
        "remaining_amount": remainingAmount,
        "total_donations": totalDonations,
        "total_volunteers": totalVolunteers,
        "total_events": totalEvents,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}




enum Status {
    ACTIVE,
    COMPLETED,
    POSTPONED
}

final statusValues = EnumValues({
    "active": Status.ACTIVE,
    "completed": Status.COMPLETED,
    "postponed": Status.POSTPONED
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
