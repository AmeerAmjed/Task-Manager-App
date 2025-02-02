class UserModel {
  final int userId;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String avatar;

  const UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.avatar,
  });
}
