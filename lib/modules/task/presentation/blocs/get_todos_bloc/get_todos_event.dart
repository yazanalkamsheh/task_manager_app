
import 'package:equatable/equatable.dart';

sealed class GetTodosEvent extends Equatable {
  const GetTodosEvent();
  @override
  List<Object> get props => [];
}

class FetchFirstTimeTodosEvent extends GetTodosEvent {
  const FetchFirstTimeTodosEvent();
}

class LoadMoreTodosEvent extends GetTodosEvent {
  const LoadMoreTodosEvent();
}

class RefreshTodosEvent extends GetTodosEvent {
  const RefreshTodosEvent();
}
