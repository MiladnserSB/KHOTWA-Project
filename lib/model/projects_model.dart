import 'dart:convert';
import 'package:meta/meta.dart';
import 'events_model.dart'; // <-- reuse your EventModel

ProjectsModel projectsModelFromJson(String str) =>
    ProjectsModel.fromJson(json.decode(str));

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
        data: List<ProjectModel>.from(
            json["data"].map((x) => ProjectModel.fromJson(x))),
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
  final String? arName; // NEW
  final String? description;
  final String? arDescription; // NEW
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String? coverImage;
  final double targetDonation;
  final int donatedAmount;
  final int remainingAmount;
  final int totalDonations;
  final int totalVolunteers;
  final int totalEvents;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<EventModel> events; // NEW

  ProjectModel({
    required this.id,
    required this.name,
    this.arName,
    this.description,
    this.arDescription,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.coverImage,
    required this.targetDonation,
    required this.donatedAmount,
    required this.remainingAmount,
    required this.totalDonations,
    required this.totalVolunteers,
    required this.totalEvents,
    this.createdAt,
    this.updatedAt,
    required this.events,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json["id"],
        name: json["name"] ?? "",
        arName: json["ar_name"],
        description: json["description"],
        arDescription: json["ar_description"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        status: (json["status"] as String?)?.toLowerCase() ?? "unknown",
        coverImage: json["cover_image"],
        targetDonation:
            double.tryParse(json["target_donation"]?.toString() ?? "") ?? 0.0,
        donatedAmount:
            int.tryParse(json["donated_amount"]?.toString() ?? "") ?? 0,
        remainingAmount:
            int.tryParse(json["remaining_amount"]?.toString() ?? "") ?? 0,
        totalDonations:
            int.tryParse(json["total_donations"]?.toString() ?? "") ?? 0,
        totalVolunteers:
            int.tryParse(json["total_volunteers"]?.toString() ?? "") ?? 0,
        totalEvents: int.tryParse(json["total_events"]?.toString() ?? "") ?? 0,
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,
        events: json["events"] == null
            ? []
            : List<EventModel>.from(
                json["events"].map((x) => EventModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ar_name": arName,
        "description": description,
        "ar_description": arDescription,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "status": statusValues.reverse[status],
        "cover_image": coverImage,
        "target_donation": targetDonation.toStringAsFixed(2),
        "donated_amount": donatedAmount,
        "remaining_amount": remainingAmount,
        "total_donations": totalDonations,
        "total_volunteers": totalVolunteers,
        "total_events": totalEvents,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
      };
}

enum Status { ACTIVE, COMPLETED, POSTPONED }

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
