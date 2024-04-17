import 'package:base_project_v2/modules/task/domin/parameters/todo_parameters.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/todo_model.dart';
import '../entities/todo_entity.dart';
import '../parameters/get_todos_parameters.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TodoEntity>>> getTodos(GetTodosParameters parameters);
  Future<Either<Failure, TodoModel>> updateTodos(TodoParameters parameters);
  Future<Either<Failure, TodoModel>> deleteTodos(TodoParameters parameters);
  Future<Either<Failure, TodoModel>> addTodos(TodoParameters parameters);

}
