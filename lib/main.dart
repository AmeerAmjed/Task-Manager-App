import 'package:flutter/material.dart';
import 'package:task_manager/DatabaseInitializer.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/ui/views/todo_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  await DatabaseInitializer.initialize();

  runApp(const ToDoApp());
}


