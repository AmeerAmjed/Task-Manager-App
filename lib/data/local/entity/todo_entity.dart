import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_manager/data/local/entity/base_entity.dart';

part 'todo_entity.g.dart';

@immutable
@JsonSerializable()
class TodoEntity extends BaseEntity {
  TodoEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.isCompleted,
  }) : super(id);

  @override
  final int id;
  final int userId;
  final String title;
  final int isCompleted;

  @override
  Map<String, dynamic> toMap() => _$TodoEntityToJson(this);

  factory TodoEntity.fromJson(Map<String, dynamic> json) =>
      _$TodoEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TodoEntityToJson(this);
}
