import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String? status;   // ✅ nullable
  final String? message;
  final String? token;    // ✅ nullable
  final User? user;       // ✅ nullable

  LoginModel({
    this.status,
    this.message,
    this.token,
    this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "user": user?.toJson(),
      };
}

class User {
  final int id;
  final String email;
  final int emailVerified;
  final int passwordVerified;
  final String username;
  final int roleId;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.email,
    required this.emailVerified,
    required this.passwordVerified,
    required this.username,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        email: json["email"] ?? "",
        emailVerified: json["email_verified"] ?? 0,
        passwordVerified: json["password_verified"] ?? 0,
        username: json["username"] ?? "",
        roleId: json["role_id"] ?? 0,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "email_verified": emailVerified,
        "password_verified": passwordVerified,
        "username": username,
        "role_id": roleId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
