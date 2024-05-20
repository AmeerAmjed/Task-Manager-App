import 'package:task_manager/domain/model/todo_model.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> getTodos();
}
