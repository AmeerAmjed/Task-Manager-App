import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_todo_response.g.dart';

@immutable
@JsonSerializable()
class DeleteTodoResponse {
  const DeleteTodoResponse({
    required this.id,
    required this.todo,
    required this.completed,
    required this.isDeleted,
    required this.userId,
  });

  final int id;
  final String todo;
  final bool completed;
  final bool isDeleted;
  final int userId;

  factory DeleteTodoResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteTodoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteTodoResponseToJson(this);
}
