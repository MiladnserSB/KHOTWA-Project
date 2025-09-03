import 'package:meta/meta.dart';
import 'dart:convert';

EventsModel eventsModelFromJson(String str) => EventsModel.fromJson(json.decode(str));
String eventsModelToJson(EventsModel data) => json.encode(data.toJson());

class EventsModel {
  final bool status;
  final String message;
  final List<EventModel> data;

  EventsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
        status: json["status"],
        message: json["message"],
        data: List<EventModel>.from(
            json["data"].map((x) => EventModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EventModel {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final int durationHours;
  final String location;
  final double? lat; // nullable
  final double? lng; // nullable
  final String status;
  final String? coverImage; // nullable
  final int requiredVolunteers;
  final int currentVolunteers;
  final int registeredCount;
  final int projectId;
  final String projectName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? qrToken; // nullable
  final String? qrTokenExpiresAt; // nullable
  final String? qrImagePath; // nullable

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.durationHours,
    required this.location,
    this.lat,
    this.lng,
    required this.status,
    this.coverImage,
    required this.requiredVolunteers,
    required this.currentVolunteers,
    required this.registeredCount,
    required this.projectId,
    required this.projectName,
    required this.createdAt,
    required this.updatedAt,
    this.qrToken,
    this.qrTokenExpiresAt,
    this.qrImagePath,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        durationHours: json["duration_hours"],
        location: json["location"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      status: (json["status"] as String?)?.toLowerCase() ?? "unknown",
        coverImage: json["cover_image"],
        requiredVolunteers: json["required_volunteers"],
        currentVolunteers: json["current_volunteers"],
        registeredCount: json["registered_count"],
        projectId: json["project_id"],
        projectName: json["project_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        qrToken: json["qr_token"],
        qrTokenExpiresAt: json["qr_token_expires_at"],
        qrImagePath: json["qr_image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date.toIso8601String(),
        "time": time,
        "duration_hours": durationHours,
        "location": location,
        "lat": lat,
        "lng": lng,
        "status": statusValues.reverse[status],
        "cover_image": coverImage,
        "required_volunteers": requiredVolunteers,
        "current_volunteers": currentVolunteers,
        "registered_count": registeredCount,
        "project_id": projectId,
        "project_name": projectName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "qr_token": qrToken,
        "qr_token_expires_at": qrTokenExpiresAt,
        "qr_image_path": qrImagePath,
      };
}

enum Status {
  OPEN,
  CLOSED,
  COMPLETED,
  UPCOMING, ACTIVE
}

final statusValues = EnumValues({
  "open": Status.OPEN,
  "closed": Status.CLOSED,
  "completed": Status.COMPLETED,
  "upcoming": Status.UPCOMING
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
