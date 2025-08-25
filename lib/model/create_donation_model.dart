// To parse this JSON data, do
//
//     final createDonationModel = createDonationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateDonationModel createDonationModelFromJson(String str) => CreateDonationModel.fromJson(json.decode(str));

String createDonationModelToJson(CreateDonationModel data) => json.encode(data.toJson());

class CreateDonationModel {
    final bool status;
    final String message;
    final Data data;

    CreateDonationModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CreateDonationModel.fromJson(Map<String, dynamic> json) => CreateDonationModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    final int donationId;
    final String status;

    Data({
        required this.donationId,
        required this.status,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        donationId: json["donation_id"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "donation_id": donationId,
        "status": status,
    };
}
