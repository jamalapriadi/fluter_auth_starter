import 'dart:convert';

class PasswordResponse {
  bool? success;
  String? message;

  Object? errors;

  PasswordResponse({this.success, this.message, this.errors});

  factory PasswordResponse.fromJson(Map<String, dynamic> json) =>
      PasswordResponse(
          success: json["success"] ?? '',
          message: json["message"] ?? '',
          errors: json["errors"] ?? '');

  Map<String, dynamic> toJson() =>
      {"success": success, "message": message, "errors": errors};
}

PasswordResponse passwordResponseFromJson(String str) =>
    PasswordResponse.fromJson(json.decode(str));
