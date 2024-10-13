class RegisterRequest {
  String name;
  String email;
  String password;
  String phone;

  RegisterRequest(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone,});

  copyWith(
          {name,
          email,
          password,
          identitas,
          phone,
          passwordConfirmation}) =>
      RegisterRequest(
          name: name ?? this.name,
          email: email ?? this.email,
          password: password ?? this.password,
          phone: phone ?? this.phone,);

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
      };
}
