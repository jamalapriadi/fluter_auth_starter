import 'dart:convert';

class UpdateProfileResponse {
  bool? success;
  String? message;

  UpdateProfileResponse({this.success, this.message});

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponse(success: json["success"], message: json["message"]);
}

UpdateProfileResponse updateProfileResponse(String str) =>
    UpdateProfileResponse.fromJson(json.decode(str));
