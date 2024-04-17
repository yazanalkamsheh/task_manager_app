import 'package:base_project_v2/core/services/cache_storage_services.dart';
import 'package:base_project_v2/modules/auth/presentation/routes/login_route.dart';
import 'package:go_router/go_router.dart';

import '../screens/add_task_screen.dart';


class AddTasksRoute {
  static const String name = '/add_task';
  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) =>
        const AddTaskScreen(),
  );
}
