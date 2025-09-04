// To parse this JSON data, do
//
//     final eventEvaluationsModel = eventEvaluationsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EventEvaluationsModel eventEvaluationsModelFromJson(String str) => EventEvaluationsModel.fromJson(json.decode(str));

String eventEvaluationsModelToJson(EventEvaluationsModel data) => json.encode(data.toJson());

class EventEvaluationsModel {
    final bool status;
    final String message;
    final EventEvaluationModel data;

    EventEvaluationsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory EventEvaluationsModel.fromJson(Map<String, dynamic> json) => EventEvaluationsModel(
        status: json["status"],
        message: json["message"],
        data: EventEvaluationModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class EventEvaluationModel {
    final int id;
    final Event event;
    final Volunteer volunteer;
    final int rating;
    final String comment;
    final DateTime createdAt;

    EventEvaluationModel({
        required this.id,
        required this.event,
        required this.volunteer,
        required this.rating,
        required this.comment,
        required this.createdAt,
    });

    factory EventEvaluationModel.fromJson(Map<String, dynamic> json) => EventEvaluationModel(
        id: json["id"],
        event: Event.fromJson(json["event"]),
        volunteer: Volunteer.fromJson(json["volunteer"]),
        rating: json["rating"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "event": event.toJson(),
        "volunteer": volunteer.toJson(),
        "rating": rating,
        "comment": comment,
        "created_at": createdAt.toIso8601String(),
    };
}

class Event {
    final int id;
    final String title;

    Event({
        required this.id,
        required this.title,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
    };
}

class Volunteer {
    final int id;
    final String name;

    Volunteer({
        required this.id,
        required this.name,
    });

    factory Volunteer.fromJson(Map<String, dynamic> json) => Volunteer(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
