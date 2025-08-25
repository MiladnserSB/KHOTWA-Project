// To parse this JSON data, do
//
//     final myDonations = myDonationsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyDonations myDonationsFromJson(String str) => MyDonations.fromJson(json.decode(str));

String myDonationsToJson(MyDonations data) => json.encode(data.toJson());

class MyDonations {
    final bool status;
    final String message;
    final List<DonationModel> data;

    MyDonations({
        required this.status,
        required this.message,
        required this.data,
    });

    factory MyDonations.fromJson(Map<String, dynamic> json) => MyDonations(
        status: json["status"],
        message: json["message"],
        data: List<DonationModel>.from(json["data"].map((x) => DonationModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DonationModel {
    final int id;
    final String type;
    final String amount;
    final dynamic description;
    final String donorName;
    final String donorEmail;
    final String method;
    final String paymentStatus;
    final dynamic transactionId;
    final String project;
    final String event;
    final DateTime donatedAt;

    DonationModel({
        required this.id,
        required this.type,
        required this.amount,
        required this.description,
        required this.donorName,
        required this.donorEmail,
        required this.method,
        required this.paymentStatus,
        required this.transactionId,
        required this.project,
        required this.event,
        required this.donatedAt,
    });

    factory DonationModel.fromJson(Map<String, dynamic> json) => DonationModel(
        id: json["id"],
        type: json["type"],
        amount: json["amount"],
        description: json["description"],
        donorName: json["donor_name"],
        donorEmail: json["donor_email"],
        method: json["method"],
        paymentStatus: json["payment_status"],
        transactionId: json["transaction_id"],
        project: json["project"],
        event: json["event"],
        donatedAt: DateTime.parse(json["donated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "amount": amount,
        "description": description,
        "donor_name": donorName,
        "donor_email": donorEmail,
        "method": method,
        "payment_status": paymentStatus,
        "transaction_id": transactionId,
        "project": project,
        "event": event,
        "donated_at": donatedAt.toIso8601String(),
    };
}
