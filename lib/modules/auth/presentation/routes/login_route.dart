import 'package:base_project_v2/core/services/cache_storage_services.dart';
import 'package:base_project_v2/modules/auth/presentation/screens/login_screen.dart';
import 'package:base_project_v2/modules/task/presentation/routes/task_route.dart';
import 'package:go_router/go_router.dart';

class LoginRoute {
  static const String name = '/login';

  static GoRoute route = GoRoute(
    path: name,
    redirect: (context, state) {
      if (CacheStorageServices().hasToken) {
        return TasksRoute.name;
      }
      return null;
    },
    builder: (context, state) => LoginScreen(),
  );
}
