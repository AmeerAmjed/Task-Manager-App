import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/ui/utils/dimens.dart';
import 'package:task_manager/ui/utils/input_validation.dart';
import 'package:task_manager/ui/views/create_todo/bloc/create_todo_bloc.dart';
import 'package:task_manager/ui/views/create_todo/widget/input_create_todo.dart';
import 'package:task_manager/ui/widget/bottom_sheet.dart';
import 'package:task_manager/ui/widget/loading_indicator.dart';

void bottomSheetCreateTodo(
  BuildContext context,
) {
  bottomSheet(
    context: context,
    height: 245.0,
    children: <Widget>[
      BlocProvider<CreateTodoBloc>(
        create: (_) => getIt<CreateTodoBloc>(),
        child: BlocConsumer<CreateTodoBloc, CreateTodoState>(
          listener: (context, state) {
            if (state is IsCreateTodoSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Successfully!"),
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(20),
                  shape: StadiumBorder(),
                  action: SnackBarAction(
                    label: 'Dismiss',
                    disabledTextColor: Colors.white,
                    textColor: Colors.blue,
                    onPressed: () {
                      //Do whatever you want
                    },
                  ),
                ),
              );
            } else if (state is IsCreateTodoFailed) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  action: SnackBarAction(
                    label: 'Dismiss',
                    disabledTextColor: Colors.white,
                    textColor: Colors.blue,
                    onPressed: () {
                      //Do whatever you want
                    },
                  ),
                ),
              );
            }
          },
          builder: (BuildContext context, state) {
            final createTodoBloc = context.read<CreateTodoBloc>();

            return Column(
              children: [
                Form(
                  key: createTodoBloc.formTitleTodoKey,
                  child: InputCreateTodo(
                    todoTitle: createTodoBloc.todoTitle,
                    completionCheckbox: Checkbox(
                        activeColor: Theme.of(context).colorScheme.primary,
                        value: createTodoBloc.isCompleted,
                        onChanged: (bool? value) {
                          if (value != null) {
                            createTodoBloc.add(
                              OnChangeIsCompleted(isCompleted: value),
                            );
                          }
                        }),
                    validator: (titleTodo) => createTodoBloc
                        .checkValidateTitleTodo(titleTodo)
                        .message,
                  ),
                ),
                Container(
                  height: 45,
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimens.spacing16,
                  ).add(
                    const EdgeInsets.only(
                      top: Dimens.spacing16,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  child: TextButton(
                    onPressed: state is LoadingUploadTodo
                        ? null
                        : () {
                            createTodoBloc.add(SubmittedCreateTodoEvent());
                          },
                    child: state is LoadingUploadTodo
                        ? const LoadingIndicator()
                        : Text(
                            'Create',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ],
  );
}
