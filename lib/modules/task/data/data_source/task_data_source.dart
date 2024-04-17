import 'package:base_project_v2/modules/task/data/models/todo_model.dart';
import 'package:base_project_v2/modules/task/domin/parameters/todo_parameters.dart';

import '../../domin/parameters/get_todos_parameters.dart';


abstract class TaskDataSource {
  Future<List<TodoModel>> getTodos(GetTodosParameters parameters);
  Future<TodoModel> updateTodo(TodoParameters parameters);
  Future<TodoModel> deleteTodo(TodoParameters parameters);
  Future<TodoModel> addTodo(TodoParameters parameters);
}
