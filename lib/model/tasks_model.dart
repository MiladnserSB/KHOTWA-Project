import 'package:meta/meta.dart';
import 'dart:convert';

// Function to parse JSON data
TasksModel tasksModelFromJson(String str) => TasksModel.fromJson(json.decode(str));

// Function to convert TasksModel to JSON
String tasksModelToJson(TasksModel data) => json.encode(data.toJson());

class TasksModel {
  final bool status;
  final String message;
  final List<TaskModel> data;

  TasksModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TasksModel.fromJson(Map<String, dynamic> json) => TasksModel(
        status: json["status"],
        message: json["message"],
        data: List<TaskModel>.from(
            json["data"].map((x) => TaskModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TaskModel {
  final int id;
  final String title;
  final String description;
  final int volunteerId;
  final int assignedBy;
  final String status;
  final String? action; // Nullable action
  final DateTime? startDate; // Nullable startDate
  final DateTime dueDate;
  final int volunteerHours;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.volunteerId,
    required this.assignedBy,
    required this.status,
    this.action, // Nullable action
    this.startDate, // Nullable startDate
    required this.dueDate,
    required this.volunteerHours,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        volunteerId: json["volunteer_id"],
        assignedBy: json["assigned_by"],
        status: json["status"],
        action: json["action"], // Nullable action
        startDate: json["start_date"] != null
            ? DateTime.parse(json["start_date"])
            : null, // Handle nullable startDate
        dueDate: DateTime.parse(json["due_date"]),
        volunteerHours: json["volunteer_hours"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "volunteer_id": volunteerId,
        "assigned_by": assignedBy,
        "status": status,
        "action": action, // Nullable action
        "start_date": startDate?.toIso8601String(),
        "due_date":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "volunteer_hours": volunteerHours,
      };

  /// ✅ Added copyWith to allow easy updates
  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    int? volunteerId,
    int? assignedBy,
    String? status,
    String? action,
    DateTime? startDate,
    DateTime? dueDate,
    int? volunteerHours,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      volunteerId: volunteerId ?? this.volunteerId,
      assignedBy: assignedBy ?? this.assignedBy,
      status: status ?? this.status,
      action: action ?? this.action,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
      volunteerHours: volunteerHours ?? this.volunteerHours,
    );
  }
}
