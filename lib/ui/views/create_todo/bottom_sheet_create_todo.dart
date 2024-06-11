import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/ui/utils/dimens.dart';
import 'package:task_manager/ui/utils/input_validation.dart';
import 'package:task_manager/ui/views/create_todo/bloc/create_todo_bloc.dart';
import 'package:task_manager/ui/views/create_todo/widget/input_create_todo.dart';
import 'package:task_manager/ui/widget/bottom_sheet.dart';
import 'package:task_manager/ui/widget/custom_button.dart';
import 'package:task_manager/utils/is_form_validated.dart';

void bottomSheetCreateTodo(
  BuildContext context,
) {
  final GlobalKey<FormState> formTitleTodoKey = GlobalKey<FormState>();
  final TextEditingController todoTitle = TextEditingController();

  bottomSheetWithKeyboard(
    context: context,
    height: 266.0,
    children: <Widget>[
      BlocConsumer<CreateTodoBloc, CreateTodoUiState>(
        listener: (context, state) {
          if (state.isCreateTodoSuccess) {
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
          } else if (state.isCreateTodoFailed) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                content: Text(state.errorMessage ?? ""),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(Dimens.spacing16),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.radius16),
                ),
                action: SnackBarAction(
                    label: 'Dismiss',
                    disabledTextColor: Colors.white,
                    textColor: Colors.blue,
                  onPressed: () {},
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
                key: formTitleTodoKey,
                child: InputCreateTodo(
                  todoTitle: todoTitle,
                  completionCheckbox: Checkbox(
                      activeColor: Theme.of(context).colorScheme.primary,
                      value: state.isCompleted,
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
              CustomButton(
                onPressed: () {
                  if (formTitleTodoKey.isFormValidated()) {
                    createTodoBloc.add(SubmittedCreateTodoEvent());
                  }
                },
                label: 'Create',
              )
            ],
          );
          },
        ),
    ],
  );
}
