import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_manager/domain/model/todo_model.dart';

class ItemTodo extends StatelessWidget {
  const ItemTodo({
    super.key,
    this.onPressed,
    this.onChangedIsCompleted,
    required this.todo,
  });

  final TodoModel todo;
  final Function()? onPressed;
  final Function(bool? value)? onChangedIsCompleted;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(todo.title),
        leading: Transform.scale(
          scale: 1.5,
          child: Checkbox(
            activeColor: Theme.of(context).colorScheme.primary,
            value: todo.isCompleted,
            onChanged: onChangedIsCompleted,
          ),
        ),
        trailing: IconButton(
          iconSize: 25,
          padding: const EdgeInsets.all(4),
          style: const ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          icon: const Icon(Icons.more_horiz),
          onPressed: onPressed,
        ),
        tileColor: Theme.of(context).colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
    );
  }
}

class ShimmerItemTodo extends StatelessWidget {
  const ShimmerItemTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ItemTodo(
        todo: TodoModel(
          id: 1,
          userId: 1,
          title: "",
          isCompleted: true,
        ),
      ),
    );
  }
}