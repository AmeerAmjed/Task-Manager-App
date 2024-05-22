import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager/data/local/local_todo_data_source.dart';
import 'package:task_manager/data/local/local_user_data_source.dart';
import 'package:task_manager/data/local/table/todo_tablle.dart';
import 'package:task_manager/data/local/table/user_table.dart';
import 'package:task_manager/data/remote/api_authentication_service.dart';
import 'package:task_manager/data/repository/authentication_repository_impl.dart';
import 'package:task_manager/di/bloc_provider.dart';
import 'package:task_manager/di/uescase_module.dart';
import 'package:task_manager/domain/repository/authentication_repository.dart';

part 'data_module.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  setupDataModule();
  setupUsecaseModule();
  setupBlocProvider();
}
