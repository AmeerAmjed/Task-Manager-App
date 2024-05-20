import 'package:task_manager/data/remote/response/todo_dto.dart';
import 'package:task_manager/domain/model/todo_model.dart';

extension ToDoModelExtension on TodoDto {
  TodoModel toToDoModel() {
    return TodoModel(
      id: id,
      userId: userId,
      title: todo,
      isCompleted: completed,
    );
  }
}