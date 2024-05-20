part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  List<Object?> get props => [];
}

class GetTodosEvent extends HomeScreenEvent {}

class CheckIfNeedMoreDataEvent extends HomeScreenEvent {
  final int index;

  const CheckIfNeedMoreDataEvent({required this.index});

  @override
  List<Object?> get props => [index];
}
