import 'package:go_router/go_router.dart';
import '../screens/favourite_screen.dart';

class FavouriteTasksRoute {
  static const String name = '/favourite_task';
  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) => const FavouriteTasksScreen(),
  );
}
