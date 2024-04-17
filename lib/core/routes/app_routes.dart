import 'package:base_project_v2/modules/auth/presentation/routes/login_route.dart';
import 'package:base_project_v2/modules/task/presentation/routes/add_task_route.dart';
import 'package:base_project_v2/modules/task/presentation/routes/favourite_task_route.dart';
import 'package:base_project_v2/modules/task/presentation/routes/task_route.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';
import '../../modules/task/presentation/routes/update_task_route.dart';
import '../services/cache_storage_services.dart';

/// The [AppRoutes] class defines a static router instance of the GoRouter class,
/// which is a routing solution commonly used in Flutter applications
/// It manages the navigation flow between different screens or pages.
/// The routes parameter specifies the available routes in the application.
/// By commenting out the class, you disable the routing functionality,
/// making it impossible to navigate between screens/pages.
///
/// defaine Route class
/// EX: class FeatureRoute {
///  static const String name = '/route';
///  static GoRoute route = GoRoute(
///    path: name,
///    builder: (context, state) => FeaturesScreen(),
///  );
/// }

class AppRoutes {
  static final router = GoRouter(
    initialLocation: LoginRoute.name,
    // TODO: add pages route here
    routes: [
      LoginRoute.route,
      TasksRoute.route,
      UpdateTasksRoute.route,
      AddTasksRoute.route,
      FavouriteTasksRoute.route,
    ],
  );
}
