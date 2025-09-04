import 'package:meta/meta.dart';
import 'dart:convert';

BadgetsModel badgetsModelFromJson(String str) => BadgetsModel.fromJson(json.decode(str));

String badgetsModelToJson(BadgetsModel data) => json.encode(data.toJson());

class BadgetsModel {
    final bool status;
    final String message;
    final List<BadgetModel> data;

    BadgetsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory BadgetsModel.fromJson(Map<String, dynamic> json) => BadgetsModel(
        status: json["status"],
        message: json["message"],
        data: List<BadgetModel>.from(json["data"].map((x) => BadgetModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class BadgetModel {
    final int id;
    final String name;
    final String slug;
    final String category;
    final String description;
    final int level;
    final String iconUrl;

    BadgetModel({
        required this.id,
        required this.name,
        required this.slug,
        required this.category,
        required this.description,
        required this.level,
        required this.iconUrl,
    });

    factory BadgetModel.fromJson(Map<String, dynamic> json) => BadgetModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        category: json["category"],
        description: json["description"],
        level: json["level"],
        iconUrl: json["icon_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "category": category,
        "description": description,
        "level": level,
        "icon_url": iconUrl,
    };
}
