import 'dart:convert';

class VerifikasiOtpResponse {
  bool? success;
  String? message;

  VerifikasiOtpResponse({this.success, this.message});

  factory VerifikasiOtpResponse.fromJson(Map<String, dynamic> json) =>
      VerifikasiOtpResponse(success: json["success"], message: json["message"]);
}

VerifikasiOtpResponse verifikasiOtpResponseFromJson(String str) =>
    VerifikasiOtpResponse.fromJson(json.decode(str));
