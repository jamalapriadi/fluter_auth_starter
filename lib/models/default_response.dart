
import 'dart:convert';

class DefaultResponse {
  bool? success;
  String? message;

  DefaultResponse({
    this.success, 
    this.message
  });

  factory DefaultResponse.fromJson(Map<String, dynamic> json) => 
    DefaultResponse(
      success: json["success"],
      message: json["message"]
    );
}

DefaultResponse defaultResponseFromJson(String str){
  final data = json.decode(str);

  return DefaultResponse.fromJson(data);
}