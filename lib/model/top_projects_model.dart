// To parse this JSON data, do
//
//     final topProjectsModel = topProjectsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TopProjectsModel topProjectsModelFromJson(String str) => TopProjectsModel.fromJson(json.decode(str));

String topProjectsModelToJson(TopProjectsModel data) => json.encode(data.toJson());

class TopProjectsModel {
    final bool status;
    final String message;
    final List<TopProject> data;

    TopProjectsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TopProjectsModel.fromJson(Map<String, dynamic> json) => TopProjectsModel(
        status: json["status"],
        message: json["message"],
        data: List<TopProject>.from(json["data"].map((x) => TopProject.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class TopProject {
    final int id;
    final String name;
    final String organization;
    final int paid;
    final int participants;
    final int eventsCount;
    final int activityScore;

    TopProject({
        required this.id,
        required this.name,
        required this.organization,
        required this.paid,
        required this.participants,
        required this.eventsCount,
        required this.activityScore,
    });

    factory TopProject.fromJson(Map<String, dynamic> json) => TopProject(
        id: json["id"] as int? ?? 0,
        name: json["name"] as String? ?? "",
        organization: json["organization"] as String? ?? "",
        paid: json["paid"] as int? ?? 0,
        participants: json["participants"] as int? ?? 0,
        eventsCount: json["events_count"] as int? ?? 0,
        activityScore: json["activity_score"] as int? ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "organization": organization,
        "paid": paid,
        "participants": participants,
        "events_count": eventsCount,
        "activity_score": activityScore,
    };
}