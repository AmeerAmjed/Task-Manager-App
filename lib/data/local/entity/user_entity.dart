import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_manager/data/local/entity/base_entity.dart';

part 'user_entity.g.dart';

@immutable
@JsonSerializable()
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
  Map<String, dynamic> toMap() => _$UserEntityToJson(this);

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
