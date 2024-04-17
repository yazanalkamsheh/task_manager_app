import 'package:base_project_v2/modules/task/data/data_source/task_data_source.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/errors_handler.dart';
import '../../../../core/errors/failure.dart';
import '../../domin/entities/todo_entity.dart';
import '../../domin/parameters/get_todos_parameters.dart';
import '../../domin/repository/task_repository.dart';
import '../models/todo_model.dart';

class TaskRepositoryImp extends TaskRepository {
  final TaskDataSource homeDataSource;
  TaskRepositoryImp(this.homeDataSource);

  @override
  Future<Either<Failure, List<TodoEntity>>> getTodos(GetTodosParameters parameters) async {
    return ErrorsHandler.handleEither(() => homeDataSource.getTodos(parameters));
  }

  @override
  Future<Either<Failure, TodoModel>> addTodos(parameters) {
    return ErrorsHandler.handleEither(() => homeDataSource.addTodo(parameters));

  }

  @override
  Future<Either<Failure, TodoModel>> deleteTodos(parameters) {
    return ErrorsHandler.handleEither(() => homeDataSource.deleteTodo(parameters));

  }

  @override
  Future<Either<Failure, TodoModel>> updateTodos(parameters) {
    return ErrorsHandler.handleEither(() => homeDataSource.updateTodo(parameters));

  }


}
