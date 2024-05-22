import 'package:task_manager/data/local/entity/todo_entity.dart';
import 'package:task_manager/domain/model/todo_model.dart';

extension ToTodoModelExtension on TodoModel {
  TodoEntity toTodoModel() {
    return TodoEntity(
      id: id,
      userId: userId,
      title: title,
      isCompleted: _boolToInt(isCompleted),
    );
  }

  int _boolToInt(bool a) => a == false ? 0 : 1;
}
