import 'package:task_manager/data/local/entity/todo_entity.dart';
import 'package:task_manager/domain/model/todo_model.dart';

extension ToTodoModelExtension on TodoEntity {
  TodoModel toTodoModel() {
    return TodoModel(
      id: id,
      userId: userId,
      title: title,
      isCompleted: _intToBool(isCompleted),
    );
  }

  bool _intToBool(int a) => a == 0 ? false : true;
}
