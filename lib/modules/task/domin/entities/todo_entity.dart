import 'package:base_project_v2/modules/task/data/models/todo_model.dart';
import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final int id;
  final String todo;
  final bool completed;
  final int userId;
  final bool isFavorite;

  const TodoEntity({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
    required this.isFavorite,
  });

  TodoEntity copyWith({bool? isFavorite}) {
    return TodoEntity(
      id: id,
      todo: todo,
      completed: completed,
      userId: userId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory TodoEntity.fromEntity(TodoModel model) {
    return TodoEntity(
      id: model.id,
      todo: model.todo,
      completed: model.completed,
      userId: model.userId,
      isFavorite: model.isFavorite,
    );
  }

  toJson() => {
    'id':id,
    'todo': todo,
    "completed": completed,
    "userId": userId,
    "isFavorite": isFavorite,
  };

  @override
  List<Object?> get props => [id, todo, completed,userId, isFavorite];
}
