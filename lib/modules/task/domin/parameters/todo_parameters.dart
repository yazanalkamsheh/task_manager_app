
import 'package:base_project_v2/core/utils/base_parameters.dart';
import 'package:base_project_v2/modules/task/domin/entities/todo_entity.dart';

import '../../../../core/utils/base_pagination_bloc/pagination_parameters.dart';

class TodoParameters extends BaseParameters {
  final int? id;
  final String? todo;
  final bool? completed;
  final int? userId;
  const TodoParameters(this.id, this.todo, this.completed, this.userId);

  @override
  Map<String, dynamic> toJson() => {
    'todo': todo,
    'completed': completed,
    'userId':userId,
  };

  Map<String, dynamic> toJsonUpdate() => {
    'todo': todo,
    'completed': completed
  };

  @override
  List<Object> get props => [id!, todo!, completed!,userId!];

}
