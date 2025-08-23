
import 'dart:convert';

LoginModelAfterOTP loginModelAfterOTPFromJson(String str) => LoginModelAfterOTP.fromJson(json.decode(str));

String loginModelAfterOTPToJson(LoginModelAfterOTP data) => json.encode(data.toJson());

class LoginModelAfterOTP {
    final String message;
    final String token;
    final User user;

    LoginModelAfterOTP({
        required this.message,
        required this.token,
        required this.user,
    });

    factory LoginModelAfterOTP.fromJson(Map<String, dynamic> json) => LoginModelAfterOTP(
        message: json["message"],
        token: json["token"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "user": user.toJson(),
    };
}

class User {
    final int id;
    final String email;
    final int emailVerified;
    final int passwordVerified;
    final String username;
    final int roleId;
    final DateTime createdAt;
    final DateTime updatedAt;

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
        id: json["id"],
        email: json["email"],
        emailVerified: json["email_verified"],
        passwordVerified: json["password_verified"],
        username: json["username"],
        roleId: json["role_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "email_verified": emailVerified,
        "password_verified": passwordVerified,
        "username": username,
        "role_id": roleId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
