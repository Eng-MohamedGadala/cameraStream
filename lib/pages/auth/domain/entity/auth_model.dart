class AuthModel {
  final String email;
  final String password;
  AuthModel({required this.email, required this.password});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        email: json["email"],
        password: json["password"],
      );
}
