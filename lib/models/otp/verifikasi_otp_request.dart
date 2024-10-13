class VerifikasiOtpRequest {
  String? email;
  String? otp;

  VerifikasiOtpRequest({this.email, this.otp});

  Map<String, dynamic> toJson() => {"email": email, "otp": otp};
}
