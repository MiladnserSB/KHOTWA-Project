import 'package:meta/meta.dart';
import 'dart:convert';

VolunteerLogModel volunteerLogModelFromJson(String str) =>
    VolunteerLogModel.fromJson(json.decode(str));

String volunteerLogModelToJson(VolunteerLogModel data) =>
    json.encode(data.toJson());

class VolunteerLogModel {
  final bool? status;
  final String? message;
  final List<VolunteerLog>? data;

  VolunteerLogModel({
    this.status,
    this.message,
    this.data,
  });

  factory VolunteerLogModel.fromJson(Map<String, dynamic> json) =>
      VolunteerLogModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null
            ? List<VolunteerLog>.from(
                json["data"].map((x) => VolunteerLog.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : [],
      };
}

class VolunteerLog {
  final DatumEvent? event;
  final Registration? registration;
  final List<Evaluation>? evaluations;

  VolunteerLog({
    this.event,
    this.registration,
    this.evaluations,
  });

  factory VolunteerLog.fromJson(Map<String, dynamic> json) => VolunteerLog(
        event: json["event"] != null ? DatumEvent.fromJson(json["event"]) : null,
        registration: json["registration"] != null
            ? Registration.fromJson(json["registration"])
            : null,
        evaluations: json["evaluations"] != null
            ? List<Evaluation>.from(
                json["evaluations"].map((x) => Evaluation.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "event": event?.toJson(),
        "registration": registration?.toJson(),
        "evaluations": evaluations != null
            ? List<dynamic>.from(evaluations!.map((x) => x.toJson()))
            : [],
      };
}

class Evaluation {
  final int? id;
  final Supervisor? volunteer;
  final EvaluationEvent? event;
  final Supervisor? supervisor;
  final int? punctuality;
  final int? workQuality;
  final int? teamwork;
  final int? initiative;
  final int? discipline;
  final String? averageRating;
  final String? notes;
  final Warning? warning;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Evaluation({
    this.id,
    this.volunteer,
    this.event,
    this.supervisor,
    this.punctuality,
    this.workQuality,
    this.teamwork,
    this.initiative,
    this.discipline,
    this.averageRating,
    this.notes,
    this.warning,
    this.createdAt,
    this.updatedAt,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) => Evaluation(
        id: json["id"],
        volunteer: json["volunteer"] != null
            ? Supervisor.fromJson(json["volunteer"])
            : null,
        event: json["event"] != null ? EvaluationEvent.fromJson(json["event"]) : null,
        supervisor: json["supervisor"] != null
            ? Supervisor.fromJson(json["supervisor"])
            : null,
        punctuality: json["punctuality"],
        workQuality: json["work_quality"],
        teamwork: json["teamwork"],
        initiative: json["initiative"],
        discipline: json["discipline"],
        averageRating: json["average_rating"],
        notes: json["notes"],
        warning: json["warning"] != null ? Warning.fromJson(json["warning"]) : null,
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "volunteer": volunteer?.toJson(),
        "event": event?.toJson(),
        "supervisor": supervisor?.toJson(),
        "punctuality": punctuality,
        "work_quality": workQuality,
        "teamwork": teamwork,
        "initiative": initiative,
        "discipline": discipline,
        "average_rating": averageRating,
        "notes": notes,
        "warning": warning?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class EvaluationEvent {
  final int? id;
  final String? title;

  EvaluationEvent({this.id, this.title});

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
  final int? id;
  final String? name;

  Supervisor({this.id, this.name});

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
  final String? reason;
  final String? status;
  final DateTime? createdAt;

  Warning({this.reason, this.status, this.createdAt});

  factory Warning.fromJson(Map<String, dynamic> json) => Warning(
        reason: json["reason"],
        status: json["status"],
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "reason": reason,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
      };
}

class DatumEvent {
  final int? id;
  final String? title;
  final String? description;
  final DateTime? date;
  final String? time;
  final int? durationHours;
  final String? location;
  final double? lat;
  final double? lng;
  final String? status;
  final dynamic coverImage;
  final int? requiredVolunteers;
  final int? currentVolunteers;
  final int? registeredCount;
  final int? projectId;
  final String? projectName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? qrToken;
  final DateTime? qrTokenExpiresAt;
  final String? qrImagePath;

  DatumEvent({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
    this.durationHours,
    this.location,
    this.lat,
    this.lng,
    this.status,
    this.coverImage,
    this.requiredVolunteers,
    this.currentVolunteers,
    this.registeredCount,
    this.projectId,
    this.projectName,
    this.createdAt,
    this.updatedAt,
    this.qrToken,
    this.qrTokenExpiresAt,
    this.qrImagePath,
  });

  factory DatumEvent.fromJson(Map<String, dynamic> json) => DatumEvent(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        date: json["date"] != null ? DateTime.tryParse(json["date"]) : null,
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
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,
        qrToken: json["qr_token"],
        qrTokenExpiresAt: json["qr_token_expires_at"] != null
            ? DateTime.tryParse(json["qr_token_expires_at"])
            : null,
        qrImagePath: json["qr_image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date?.toIso8601String(),
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "qr_token": qrToken,
        "qr_token_expires_at": qrTokenExpiresAt?.toIso8601String(),
        "qr_image_path": qrImagePath,
      };
}

class Registration {
  final int? id;
  final int? volunteerId;
  final int? eventId;
  final String? status;
  final DateTime? joinedAt;

  Registration({this.id, this.volunteerId, this.eventId, this.status, this.joinedAt});

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        id: json["id"],
        volunteerId: json["volunteer_id"],
        eventId: json["event_id"],
        status: json["status"],
        joinedAt: json["joined_at"] != null ? DateTime.tryParse(json["joined_at"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "volunteer_id": volunteerId,
        "event_id": eventId,
        "status": status,
        "joined_at": joinedAt?.toIso8601String(),
      };
}
