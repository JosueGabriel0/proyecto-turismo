class RegisterDto {
  final String username;
  final String password;
  final String nombres;

  RegisterDto({required this.username, required this.password, required this.nombres});

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "nombres": nombres,
  };
}