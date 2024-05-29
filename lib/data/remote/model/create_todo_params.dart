import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

@immutable
class CreateTodoParams {
  final int userId;
  final String title;
  final bool isCompleted;

  const CreateTodoParams({
    required this.userId,
    required this.title,
    required this.isCompleted,
  });

  Map<String, dynamic> toBody() => {
        "userId": userId,
        "todo": title,
        "completed": isCompleted,
      };
}
