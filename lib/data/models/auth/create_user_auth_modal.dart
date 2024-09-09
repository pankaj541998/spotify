class CreateUserRequest {
  final String username;
  final String email;
  final String password;

  CreateUserRequest({
    required this.username,
    required this.email,
    required this.password,
  });
}
