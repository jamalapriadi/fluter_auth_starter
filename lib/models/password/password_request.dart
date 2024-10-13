class PasswordRequest {
  String email;

  PasswordRequest({required this.email});

  copyWith({email}) => PasswordRequest(email: email ?? this.email);

  Map<String, dynamic> toJson() => {"email": email};
}
