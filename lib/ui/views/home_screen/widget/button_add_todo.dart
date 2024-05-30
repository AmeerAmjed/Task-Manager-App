import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/dimens.dart';
import 'package:task_manager/ui/views/create_todo/bottom_sheet_create_todo.dart';

class ButtonAddTodo extends StatelessWidget {
  const ButtonAddTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Add todo',
      onPressed: () {

        bottomSheetCreateTodo(context);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radius16),
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: Dimens.icon24,
      ),
    );
  }
}
