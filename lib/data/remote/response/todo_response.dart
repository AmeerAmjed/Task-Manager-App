import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_response.g.dart';

@immutable
@JsonSerializable()
class TodoResponse {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  const TodoResponse({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory TodoResponse.fromJson(Map<String, dynamic> json) =>
      _$TodoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TodoResponseToJson(this);
}
