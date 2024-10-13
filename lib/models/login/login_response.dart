import 'dart:convert';

LoginSuccessResponse loginSuccessResponseFromJson(String str) =>
    LoginSuccessResponse.fromJson(json.decode(str));

class LoginSuccessResponse {
  LoginSuccessResponse({
    this.success,
    this.message,
    this.accessToken,
    this.tokenType,
    this.errors,
    this.name,
    this.email,
    this.status,
  });

  bool? success;
  String? message;
  String? accessToken;
  String? tokenType;
  String? name;
  String? email;
  int? status;

  Object? errors;

  factory LoginSuccessResponse.fromJson(Map<String, dynamic> json) =>
      LoginSuccessResponse(
          tokenType: json["token_type"] ?? '',
          accessToken: json["access_token"] ?? '',
          success: json["success"] ?? '',
          message: json["message"],
          errors: json["errors"] ?? '',
          name: json["name"] ?? '',
          email: json["email"] ?? '',
          status: json["status"]);

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        "access_token": accessToken,
        "message": message,
        "success": success,
        "errors": errors,
        "name": name,
        "email": email,
        "status": status
      };
}
