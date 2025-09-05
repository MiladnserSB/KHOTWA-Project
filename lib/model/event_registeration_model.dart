import 'profile_model.dart';

class EventRegistration {
  final int id;
  final int volunteerId;
  final int eventId;
  final String status;
  final String joinedAt;
  final Profile volunteer;
  final bool? isSelected; // ✅ UI selection

  EventRegistration({
    required this.id,
    required this.volunteerId,
    required this.eventId,
    required this.status,
    required this.joinedAt,
    required this.volunteer,
    this.isSelected = false,
  });

  factory EventRegistration.fromJson(Map<String, dynamic> json) {
    return EventRegistration(
      id: json['id'],
      volunteerId: json['volunteer_id'],
      eventId: json['event_id'],
      status: json['status'],
      joinedAt: json['joined_at'],
      volunteer: Profile.fromJson(json['volunteer']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "volunteer_id": volunteerId,
      "event_id": eventId,
      "status": status,
      "joined_at": joinedAt,
      "volunteer": volunteer.toJson(),
    };
  }

  EventRegistration copyWith({bool? isSelected}) {
    return EventRegistration(
      id: id,
      volunteerId: volunteerId,
      eventId: eventId,
      status: status,
      joinedAt: joinedAt,
      volunteer: volunteer,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
