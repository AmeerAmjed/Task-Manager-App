import 'package:task_manager/data/local/entity/base_entity.dart';

class UserEntity extends BaseEntity {
  UserEntity({
    this.id = 0,
    required this.userId,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.avatar,
  }) : super(userId);

  @override
  final int id;
  final int userId;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String avatar;

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'username': username,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'avatar': avatar,
      };
}
