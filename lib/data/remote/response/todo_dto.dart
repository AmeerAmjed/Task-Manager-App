import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'todo_dto.g.dart';


@immutable
@JsonSerializable()
class TodoDto {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  const TodoDto({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory TodoDto.fromJson(Map<String, dynamic> json) => _$TodoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoDtoToJson(this);
}