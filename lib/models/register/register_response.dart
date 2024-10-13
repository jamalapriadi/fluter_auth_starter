import 'dart:convert';

class RegisterResponse {
  bool? success;
  String? message;

  Object? errors;
  String? email;

  RegisterResponse({this.success, this.message, this.errors, this.email});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
          success: json["success"] ?? true,
          message: json["message"] ?? '',
          errors: json["errors"] ?? '',
          email: json["data"]["email"] ?? '');
}

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));
