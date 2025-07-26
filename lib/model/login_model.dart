import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    final String status;
    final String message;
    final String email;
    final String token;

    LoginModel({
        required this.status,
        required this.message,
        required this.email,
        required this.token,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        email: json["email"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "email": email,
        "token": token,
    };
}
