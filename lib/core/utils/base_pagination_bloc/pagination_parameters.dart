import 'package:base_project_v2/core/utils/base_parameters.dart';

abstract class PaginationParameters extends BaseParameters {
  final int skip;
  final int limit;

   const PaginationParameters({
    required this.skip,
    required this.limit,
  });

  @override
  Map<String, dynamic> toJson();

  @override
  List<Object> get props => [
        skip,
        limit,
      ];
}
