
import '../../domin/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel({
    required super.id,
    required super.todo,
    required super.completed,
    required super.userId,
    required super.isFavorite,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

}

