import 'package:dio/dio.dart';
import 'package:task_manager/data/remote/response/todos_response.dart';
import 'package:task_manager/data/remote/todo_api_endpoint.dart';

abstract class ApiToDoService {
  Future<TodosResponse> getTodos({required int skip, required int limit});
}

class ApiToDoServiceImpl extends ApiToDoService with TodoApiEndpoint {
  ApiToDoServiceImpl({required this.client});

  final Dio client;

  @override
  Future<TodosResponse> getTodos(
      {required int skip, required int limit}) async {
    try {
      final response = await client.get(
        '$baseUrl/todos',
        queryParameters: {
          "skip": skip,
          "limit": limit,
        },
      );

      if (response.statusCode == 200) {
        return TodosResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      throw Exception('Failed to load todos: $e');
    }
  }
}
