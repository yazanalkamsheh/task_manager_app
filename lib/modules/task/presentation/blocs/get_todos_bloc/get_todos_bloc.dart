import 'dart:async';
import 'package:base_project_v2/core/utils/base_pagination_bloc/pagination_bloc.dart';
import 'package:base_project_v2/core/utils/base_pagination_bloc/pagination_state.dart';
import 'package:bloc/src/bloc.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../domin/entities/todo_entity.dart';
import '../../../domin/parameters/get_todos_parameters.dart';
import '../../../domin/repository/task_repository.dart';
import 'get_todos_event.dart';

class GetTodosBloc extends PaginationBloc<GetTodosEvent, TodoEntity> {
  final TaskRepository taskRepository;

  GetTodosBloc(this.taskRepository) : super(initialMaxResultCount: 8) {
    on<FetchFirstTimeTodosEvent>(fetchDataFirstTime);
    on<LoadMoreTodosEvent>(loadMoreData);
    on<RefreshTodosEvent>(refresh);
  }

  @override
  FutureOr<void> fetchDataFirstTime(GetTodosEvent event, Emitter<PaginationState<List<TodoEntity>>> emit) async{
    emit(state.loading());
    final result = await taskRepository.getTodos(GetTodosParameters(skip: state.skip, limit: state.limit));
    logger.d("============ Fetch Data First Time =============== \n skipCount: ${state.skip} \n maxResultCount: ${state.limit}");
    handleResult(result, emit);
  }

  @override
  FutureOr<void> loadMoreData(GetTodosEvent event, Emitter<PaginationState<List<TodoEntity>>> emit) async{
    final result = await taskRepository.getTodos(GetTodosParameters(skip: state.skip, limit: state.limit));
    logger.d("============ Load More =============== \n skipCount: ${state.skip} \n maxResultCount: ${state.limit}");
    handleResult(result, emit);
  }

  @override
  FutureOr<void> refresh(GetTodosEvent event, Emitter<PaginationState<List<TodoEntity>>> emit) {
    emit(state.refresh());
    logger.d("============ Refresh State =============== \n skipCount: ${state.skip} \n maxResultCount: ${state.limit}");
  }
}
