// To parse this JSON data, do
//
//     final eventsModel = eventsModelFromJson(jsonString);

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
        data: List<EventModel>.from(json["data"].map((x) => EventModel.fromJson(x))),
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
  final double lat;
  final double lng;
  final String status;
  final int requiredVolunteers;
  final int registeredCount;
  final int projectId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Project project;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.durationHours,
    required this.location,
    required this.lat,
    required this.lng,
    required this.status,
    required this.requiredVolunteers,
    required this.registeredCount,
    required this.projectId,
    required this.createdAt,
    required this.updatedAt,
    required this.project,
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
        status: json["status"],
        requiredVolunteers: json["required_volunteers"],
        registeredCount: json["registered_count"],
        projectId: json["project_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        project: Project.fromJson(json["project"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "duration_hours": durationHours,
        "location": location,
        "lat": lat,
        "lng": lng,
        "status": status,
        "required_volunteers": requiredVolunteers,
        "registered_count": registeredCount,
        "project_id": projectId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "project": project.toJson(),
      };
}

class Project {
  final int id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
