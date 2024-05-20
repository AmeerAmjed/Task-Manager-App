import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

part 'data_module.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  setupDataModule();
}
