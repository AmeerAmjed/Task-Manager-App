import 'package:flutter/cupertino.dart';
import 'package:task_manager/ui/utils/assets.dart';
import 'package:task_manager/ui/utils/dimens.dart';
import 'package:task_manager/ui/widget/empty.dart';

class EmptyTodoSaved extends StatelessWidget {
  const EmptyTodoSaved({super.key});

  @override
  Widget build(BuildContext context) {
    return Empty(
      title: 'No todos saved yet',
      description:
          'Your saved todos will appear here. Start saving your important tasks to see them listed.',
      image: Container(
        height: 300,
        margin: const EdgeInsets.only(right: Dimens.spacing8),
        child: Image(
          image: AssetImage(Assets.emptyTodoSaved),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
