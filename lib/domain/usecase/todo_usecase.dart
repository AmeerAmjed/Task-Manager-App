import 'package:task_manager/data/repository/todo_repository_impl.dart';
import 'package:task_manager/domain/model/todo_model.dart';
import 'package:task_manager/domain/repository/todo_repository.dart';

class TodoUsease {
  final TodoRepository repo = TodoRepositoryImpl();

  Future<List<TodoModel>> getTodos() {
    return repo.getTodos();
  }

}