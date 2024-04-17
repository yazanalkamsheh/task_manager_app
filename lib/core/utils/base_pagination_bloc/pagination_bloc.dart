import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../errors/failure.dart';
import 'pagination_state.dart';

abstract class PaginationBloc<Event, Entity> extends Bloc<Event, PaginationState<List<Entity>>> {

  PaginationBloc({required int initialMaxResultCount})
      : super(PaginationState<List<Entity>>(
            limit: initialMaxResultCount));

  FutureOr<void> fetchDataFirstTime(Event event, Emitter<PaginationState<List<Entity>>> emit);

  FutureOr<void> loadMoreData(Event event, Emitter<PaginationState<List<Entity>>> emit);

  FutureOr<void> refresh(Event event, Emitter<PaginationState<List<Entity>>> emit);

  void handleResult(Either<Failure, List<Entity>> result,
      Emitter<PaginationState<List<Entity>>> emit) {
    result.fold(
      (failure) {
        if(state.data == null) {
          emit(state.error(failure));
        } else{
          emit(state.copyWith(failure: failure));
        }
      },
      (data) {
        if (_hasReachMax(data)) {
          final result = _appendLastElements(data);
          emit(result);
        }else {
          final result = _appendPage(data, hasReachMax: false);
          emit(result);
        }
      },
    );
  }

  PaginationState<List<Entity>> _appendPage(List<Entity> newItems,
      {required bool hasReachMax}) {
    final data = state.data ?? []
    ..addAll(newItems);
    final skipCount = state.skip + newItems.length;
    return state.success(data,skipCount,hasReachMax);
  }

  bool _hasReachMax(List<Entity> data) => data.length < state.limit;

  PaginationState<List<Entity>> _appendLastElements(List<Entity> newItems) =>
      _appendPage(newItems, hasReachMax: true);


}
