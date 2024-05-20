import 'package:flutter/material.dart';
import 'package:task_manager/domain/model/todo_model.dart';

class ItemTodo extends StatelessWidget {
  const ItemTodo({
    super.key,
    required this.todo,
  });

  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(todo.title),
        leading: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: todo.isCompleted,
          onChanged: (bool? value) {},
        ),
        trailing: IconButton(
          iconSize: 30,
          padding: const EdgeInsets.all(4),
          style: const ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          icon: const Icon(Icons.more_horiz),
          onPressed: () {},
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
    );
  }
}
