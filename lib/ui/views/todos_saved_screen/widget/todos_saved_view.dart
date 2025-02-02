import 'package:flutter/material.dart';
import 'package:task_manager/domain/model/todo_model.dart';
import 'package:task_manager/ui/views/home_screen/widget/item_todo.dart';

class TodosSavedView extends StatelessWidget {
  const TodosSavedView({
    super.key,
    required this.todos,
    required this.onClickMoreOptions,
  });

  final List<TodoModel> todos;
  final Function(int todoId) onClickMoreOptions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemTodo(
            todo: todos[index],
            onPressed: () {
              onClickMoreOptions(todos[index].id);
            },
          );
        },
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
