// To parse this JSON data, do
//
//     final volunteerLogModel = volunteerLogModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VolunteerLogModel volunteerLogModelFromJson(String str) => VolunteerLogModel.fromJson(json.decode(str));

String volunteerLogModelToJson(VolunteerLogModel data) => json.encode(data.toJson());

class VolunteerLogModel {
    final bool status;
    final String message;
    final List<Datum> data;

    VolunteerLogModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory VolunteerLogModel.fromJson(Map<String, dynamic> json) => VolunteerLogModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    final DatumEvent event;
    final Registration registration;
    final List<Evaluation> evaluations;

    Datum({
        required this.event,
        required this.registration,
        required this.evaluations,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        event: DatumEvent.fromJson(json["event"]),
        registration: Registration.fromJson(json["registration"]),
        evaluations: List<Evaluation>.from(json["evaluations"].map((x) => Evaluation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "event": event.toJson(),
        "registration": registration.toJson(),
        "evaluations": List<dynamic>.from(evaluations.map((x) => x.toJson())),
    };
}

class Evaluation {
    final int id;
    final Supervisor volunteer;
    final EvaluationEvent event;
    final Supervisor supervisor;
    final int punctuality;
    final int workQuality;
    final int teamwork;
    final int initiative;
    final int discipline;
    final String averageRating;
    final String notes;
    final Warning warning;
    final DateTime createdAt;
    final DateTime updatedAt;

    Evaluation({
        required this.id,
        required this.volunteer,
        required this.event,
        required this.supervisor,
        required this.punctuality,
        required this.workQuality,
        required this.teamwork,
        required this.initiative,
        required this.discipline,
        required this.averageRating,
        required this.notes,
        required this.warning,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Evaluation.fromJson(Map<String, dynamic> json) => Evaluation(
        id: json["id"],
        volunteer: Supervisor.fromJson(json["volunteer"]),
        event: EvaluationEvent.fromJson(json["event"]),
        supervisor: Supervisor.fromJson(json["supervisor"]),
        punctuality: json["punctuality"],
        workQuality: json["work_quality"],
        teamwork: json["teamwork"],
        initiative: json["initiative"],
        discipline: json["discipline"],
        averageRating: json["average_rating"],
        notes: json["notes"],
        warning: Warning.fromJson(json["warning"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "volunteer": volunteer.toJson(),
        "event": event.toJson(),
        "supervisor": supervisor.toJson(),
        "punctuality": punctuality,
        "work_quality": workQuality,
        "teamwork": teamwork,
        "initiative": initiative,
        "discipline": discipline,
        "average_rating": averageRating,
        "notes": notes,
        "warning": warning.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class EvaluationEvent {
    final int id;
    final String title;

    EvaluationEvent({
        required this.id,
        required this.title,
    });

    factory EvaluationEvent.fromJson(Map<String, dynamic> json) => EvaluationEvent(
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
    };
}

class Supervisor {
    final int id;
    final String name;

    Supervisor({
        required this.id,
        required this.name,
    });

    factory Supervisor.fromJson(Map<String, dynamic> json) => Supervisor(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Warning {
    final String reason;
    final String status;
    final DateTime createdAt;

    Warning({
        required this.reason,
        required this.status,
        required this.createdAt,
    });

    factory Warning.fromJson(Map<String, dynamic> json) => Warning(
        reason: json["reason"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "reason": reason,
        "status": status,
        "created_at": createdAt.toIso8601String(),
    };
}

class DatumEvent {
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
    final dynamic coverImage;
    final int requiredVolunteers;
    final int currentVolunteers;
    final int registeredCount;
    final int projectId;
    final String projectName;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String qrToken;
    final DateTime qrTokenExpiresAt;
    final String qrImagePath;

    DatumEvent({
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
        required this.coverImage,
        required this.requiredVolunteers,
        required this.currentVolunteers,
        required this.registeredCount,
        required this.projectId,
        required this.projectName,
        required this.createdAt,
        required this.updatedAt,
        required this.qrToken,
        required this.qrTokenExpiresAt,
        required this.qrImagePath,
    });

    factory DatumEvent.fromJson(Map<String, dynamic> json) => DatumEvent(
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
        coverImage: json["cover_image"],
        requiredVolunteers: json["required_volunteers"],
        currentVolunteers: json["current_volunteers"],
        registeredCount: json["registered_count"],
        projectId: json["project_id"],
        projectName: json["project_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        qrToken: json["qr_token"],
        qrTokenExpiresAt: DateTime.parse(json["qr_token_expires_at"]),
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
        "status": status,
        "cover_image": coverImage,
        "required_volunteers": requiredVolunteers,
        "current_volunteers": currentVolunteers,
        "registered_count": registeredCount,
        "project_id": projectId,
        "project_name": projectName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "qr_token": qrToken,
        "qr_token_expires_at": qrTokenExpiresAt.toIso8601String(),
        "qr_image_path": qrImagePath,
    };
}

class Registration {
    final int id;
    final int volunteerId;
    final int eventId;
    final String status;
    final DateTime joinedAt;

    Registration({
        required this.id,
        required this.volunteerId,
        required this.eventId,
        required this.status,
        required this.joinedAt,
    });

    factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        id: json["id"],
        volunteerId: json["volunteer_id"],
        eventId: json["event_id"],
        status: json["status"],
        joinedAt: DateTime.parse(json["joined_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "volunteer_id": volunteerId,
        "event_id": eventId,
        "status": status,
        "joined_at": joinedAt.toIso8601String(),
    };
}
