import 'dart:convert';

class UpdateFotoResponse {
  bool? success;
  String? message;

  UpdateFotoResponse({this.success, this.message});

  factory UpdateFotoResponse.fromJson(Map<String, dynamic> json) =>
      UpdateFotoResponse(success: json["success"], message: json["message"]);
}

UpdateFotoResponse updateFotoResponse(String str) =>
    UpdateFotoResponse.fromJson(json.decode(str));
