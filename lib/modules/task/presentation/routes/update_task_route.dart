import 'package:base_project_v2/core/services/cache_storage_services.dart';
import 'package:base_project_v2/modules/auth/presentation/routes/login_route.dart';
import 'package:base_project_v2/modules/task/domin/entities/todo_entity.dart';
import 'package:base_project_v2/modules/task/presentation/screens/update_task_screen.dart';
import 'package:go_router/go_router.dart';


class UpdateTasksRoute {
  static const String name = '/update_task';
  static GoRoute route = GoRoute(
    path: name,
    redirect: (context, state) {
      if (!CacheStorageServices().hasToken) return LoginRoute.name;
      return null;
    },
    builder: (context, state) =>
        UpdateTaskScreen(todoEntity: state.extra as TodoEntity),
  );
}
