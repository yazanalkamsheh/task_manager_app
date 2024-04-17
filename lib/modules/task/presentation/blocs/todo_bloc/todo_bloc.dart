import 'dart:async';

import 'package:base_project_v2/modules/task/domin/entities/todo_entity.dart';
import 'package:base_project_v2/modules/task/presentation/blocs/todo_bloc/todo_event.dart';
import 'package:bloc/src/bloc.dart';
import '../../../../../core/utils/base_state.dart';
import '../../../domin/repository/task_repository.dart';

class TodoBloc extends Bloc<TodoEvent, BaseState<TodoEntity>> {
  final TaskRepository taskRepository;

  TodoBloc(this.taskRepository) : super(const BaseState<TodoEntity>()) {
    on<AddTodoEvent>(_addTodo);
    on<DeleteTodoEvent>(_deleteTodo);
    on<UpdateTodoEvent>(_updateTodo);
  }

  FutureOr<void> _addTodo(AddTodoEvent event, Emitter<BaseState<TodoEntity>> emit) async{
    emit(state.loading());
    final result = await taskRepository.addTodos(event.parameters);
    result.fold((l) => emit(state.error(l)), (r) => emit(state.success(r)));
  }

  FutureOr<void> _deleteTodo(DeleteTodoEvent event, Emitter<BaseState<TodoEntity>> emit) async{
    emit(state.loading());
    final result = await taskRepository.deleteTodos(event.parameters);
    result.fold((l) => emit(state.error(l)), (r) => emit(state.success(r)));
  }

  FutureOr<void> _updateTodo(UpdateTodoEvent event, Emitter<BaseState<TodoEntity>> emit) async{
    emit(state.loading());
    final result = await taskRepository.updateTodos(event.parameters);
    result.fold((l) => emit(state.error(l)), (r) => emit(state.success(r)));
  }
}
