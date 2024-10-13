class LoginRequest {
  String? email;
  String? password;

  LoginRequest({this.email, this.password});

  copyWith({email, password}) => LoginRequest(
      email: email ?? this.email, password: password ?? this.password);

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}
