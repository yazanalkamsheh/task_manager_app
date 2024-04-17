import 'package:base_project_v2/modules/task/domin/parameters/todo_parameters.dart';
import 'package:equatable/equatable.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object> get props => [];
}

class AddTodoEvent extends TodoEvent{
  final TodoParameters parameters;
  const AddTodoEvent(this.parameters);
}

class DeleteTodoEvent extends TodoEvent{
  final TodoParameters parameters;
  const DeleteTodoEvent(this.parameters);
}
class UpdateTodoEvent extends TodoEvent{
  final TodoParameters parameters;
  const UpdateTodoEvent(this.parameters);
}