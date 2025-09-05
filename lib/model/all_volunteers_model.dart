import 'package:khotwa/model/profile_model.dart';

class AllVolunteersModel {
  final bool status;
  final String message;
  final List<Profile> data;

  AllVolunteersModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AllVolunteersModel.fromJson(Map<String, dynamic> json) {
    return AllVolunteersModel(
      status: json["status"],
      message: json["message"],
      data: List<Profile>.from(
        json["data"].map((x) => Profile.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
