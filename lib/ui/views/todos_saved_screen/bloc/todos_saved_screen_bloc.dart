import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todos_saved_screen_event.dart';
part 'todos_saved_screen_state.dart';

class TodosSavedScreenBloc
    extends Bloc<TodosSavedScreenEvent, TodosSavedScreenState> {
  TodosSavedScreenBloc() : super(TodosSavedScreenInitial()) {
    on<TodosSavedScreenEvent>((event, emit) async {


    });
  }
}
