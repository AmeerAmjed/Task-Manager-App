import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_manager/data/remote/response/todo_dto.dart';
part 'todos_response.g.dart';

@immutable
@JsonSerializable()
class TodosResponse {
  final List<TodoDto> todos;
  final int total;
  final int skip;
  final int limit;

  const TodosResponse({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory TodosResponse.fromJson(Map<String, dynamic> json) =>
      _$TodosResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TodosResponseToJson(this);
}
