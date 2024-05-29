import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/dimens.dart';

class InputCreateTodo extends StatelessWidget {
  const InputCreateTodo({
    super.key,
    required this.todoTitle,
    required this.validator,
    required this.completionCheckbox,
  });

  final TextEditingController todoTitle;
  final Widget completionCheckbox;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.radius16),
        ),
      ),
      child: TextFormField(
        controller: todoTitle,
        autofocus: true,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          fillColor: Theme.of(context).colorScheme.surface,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: completionCheckbox,
          ),
          hintText: "Write what's on your mind?",
          hintStyle: Theme.of(context).textTheme.bodyLarge,
        ),
        maxLength: 150,
      ),
    );
  }
}
