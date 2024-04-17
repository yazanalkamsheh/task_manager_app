import 'package:base_project_v2/core/utils/base_pagination_bloc/pagination_parameters.dart';

class GetTodosParameters extends PaginationParameters {
  const GetTodosParameters({required super.skip, required super.limit});

  @override
  Map<String, dynamic> toJson() => {
    'skip':skip,
    'limit': limit
  };
  @override
  List<Object> get props => [skip, limit];
}
