import 'package:go_router/go_router.dart';

import '../screens/task_screen.dart';

class TasksRoute {
  static const String name = '/task';
  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) => const TasksScreen(),
  );
}
