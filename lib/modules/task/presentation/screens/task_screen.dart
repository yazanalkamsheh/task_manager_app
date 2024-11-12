import 'package:base_project_v2/core/core_component/failure_component.dart';
import 'package:base_project_v2/core/core_component/loading_component.dart';
import 'package:base_project_v2/core/core_component/pagination_list_view_component.dart';
import 'package:base_project_v2/core/utils/base_pagination_bloc/pagination_state.dart';
import 'package:base_project_v2/core/utils/base_state.dart';
import 'package:base_project_v2/generated/locale_keys.g.dart';
import 'package:base_project_v2/modules/task/domin/entities/todo_entity.dart';
import 'package:base_project_v2/modules/task/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:base_project_v2/modules/task/presentation/routes/add_task_route.dart';
import 'package:base_project_v2/modules/task/presentation/routes/favourite_task_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/core_component/state_builder.dart';
import '../../../../core/services/cache_storage_services.dart';
import '../../../../core/services/service_locator.dart';
import '../blocs/get_todos_bloc/get_todos_bloc.dart';
import '../blocs/get_todos_bloc/get_todos_event.dart';
import '../components/app_drawer.dart';
import '../components/todo_component.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TodoEntity> todoListCached = [];
  List<TodoEntity> todoListNetwork = [];

  // Update Fav With Complexity (n)
  void updateFav() {
    Map<int, TodoEntity> map = {};
    for (TodoEntity todoEntityCached in todoListCached) {
      map[todoEntityCached.id] = todoEntityCached;
    }

    for (int i = 0; i < todoListNetwork.length; i++) {
      TodoEntity? matchingTask = map[todoListNetwork[i].id];
      if (matchingTask != null) {
        todoListNetwork[i] =
            todoListNetwork[i].copyWith(isFavorite: matchingTask.isFavorite);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // provided a bloc
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<GetTodosBloc>()..add(const FetchFirstTimeTodosEvent()),
        ),
        BlocProvider(
          create: (context) => sl<TodoBloc>(),
        ),
      ],
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          elevation: 1,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(16),
                  bottomStart: Radius.circular(16))),
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.green,
          centerTitle: true,
          title: Text(
            LocaleKeys.todos.tr(context: context),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                todoListCached.addAll(await context
                        .push<List<TodoEntity>>(FavouriteTasksRoute.name) ??
                    []);
                if (todoListCached.isNotEmpty) {
                  updateFav();
                }
                setState(() {});
              },
              icon: const Icon(
                Icons.favorite,
                color: AppColors.red,
              ),
            ),
          ],
        ),
        body: BlocListener<TodoBloc, BaseState<TodoEntity>>(
          listener: (context, state) {
            if (state.isSuccess) {
              _showResultForDeleteDialog(context, state.data!);
            }
          },
          child: StateBuilder<GetTodosBloc, PaginationState<List<TodoEntity>>>(
            onLoading: () => const LoadingComponent(),
            onSuccess: (context, data, hasReachMax){
              todoListNetwork.clear();
              todoListNetwork.addAll(data!);
                return PaginatedListView<TodoEntity>(
                  padding: EdgeInsetsDirectional.all(3.w),
                  separatorBuilder: (context,index) => SizedBox(height: 4.w),
                  itemBuilder: (index, entity) =>
                      StatefulBuilder(builder: (context, setState) {
                    return TodoComponent(
                      todoEntity: entity,
                      onPressedFavorite: () async {
                        if (entity.isFavorite) {
                          entity = entity.copyWith(isFavorite: false);
                          await CacheStorageServices()
                              .removeTodoFromFavorites(entity);
                        } else {
                          entity = entity.copyWith(isFavorite: true);
                          CacheStorageServices().addToFavorites(entity);
                        }
                        setState(() {});
                      },
                    );
                  }),
                  onCallMoreData: () => context
                      .read<GetTodosBloc>().add(const LoadMoreTodosEvent()),
                hasReachMax: hasReachMax,
                data: data,
                onRefresh: () {
                  context.read<GetTodosBloc>().add(const RefreshTodosEvent());
                  context.read<GetTodosBloc>().add(const FetchFirstTimeTodosEvent());
                },
              );
            },
            onFailure: (context,failure) => FailureComponent(
            failure: failure,
            onTryAgain: () => context.read<GetTodosBloc>().add(const FetchFirstTimeTodosEvent()),
          ),
          )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push(AddTasksRoute.name),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showResultForDeleteDialog(
          BuildContext context, TodoEntity todoEntity) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(LocaleKeys.deleteResult.tr(context: context), style: Theme.of(context).textTheme.bodySmall),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Todo: ${todoEntity.todo}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "Completed: ${todoEntity.completed}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                LocaleKeys.yes.tr(context: context),
              ),
            ),
          ],
        ),
      );
}
