import 'dart:convert';

class UpdatePasswordResponse {
  bool? success;
  String? message;

  UpdatePasswordResponse({this.success, this.message});

  factory UpdatePasswordResponse.fromJson(Map<String, dynamic> json) =>
      UpdatePasswordResponse(
          success: json["success"], message: json["message"]);
}

UpdatePasswordResponse updatePasswordResponse(String str) =>
    UpdatePasswordResponse.fromJson(json.decode(str));
