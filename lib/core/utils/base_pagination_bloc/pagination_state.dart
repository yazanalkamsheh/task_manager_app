import '../../enums/request_status.dart';
import '../../errors/failure.dart';
import '../base_state.dart';

class PaginationState<T> extends BaseState<T> {
  // Represents the page size when request returned pagination data
  final int skip;
  final int limit;
  final bool hasReachMax;

  const PaginationState({
    super.data,
    super.failure,
    super.requestStatus,
    this.skip = 0,
    required this.limit,
    this.hasReachMax = false,
  });

  //Creates a copy of the BaseState object with optional parameter values overridden
  @override
  PaginationState<T> copyWith({
    RequestStatus? requestStatus,
    Failure? failure,
    T? data,
    int? skipCount,
    int? maxResultCount,
    bool? hasReachMax,
  }) =>
      PaginationState<T>(
        data: data ?? this.data,
        failure: failure ?? this.failure,
        requestStatus: requestStatus ?? this.requestStatus,
        skip: skipCount ?? this.skip,
        limit: maxResultCount ?? this.limit,
        hasReachMax: hasReachMax ?? this.hasReachMax,
      );

  // Returns a new BaseState object with the request status set to loading
  @override
  PaginationState<T> loading() {
    return copyWith(requestStatus: RequestStatus.loading);
  }

  // Returns a new BaseState object with the request status set to success and new data
  @override
  PaginationState<T> success(T newData , [int? skipCount, bool? hasReachMax]) {
    return copyWith(
      requestStatus: RequestStatus.success,
      data: newData,
      skipCount: skipCount,
      hasReachMax: hasReachMax,
    );
  }

  // Returns a new BaseState object with the request status set to error and new failure
  @override
  PaginationState<T> error(Failure newFailure) {
    return copyWith(
      requestStatus: RequestStatus.error,
      failure: newFailure,
    );
  }

  // Returns a new BaseState object with the request status set to error and a default failure
  @override
  PaginationState<T> defaultError() {
    return copyWith(
      requestStatus: RequestStatus.error,
      failure: UnknownFailure(),
    );
  }

  // Returns a new BaseState object with all properties reset to their initial values
  @override
  PaginationState<T> reset() =>
      PaginationState<T>(limit: limit);


  PaginationState<T> refresh() {
    return PaginationState<T>(
      data: null,
      requestStatus: requestStatus,
      failure: failure,
      skip: 0,
      limit: limit,
      hasReachMax: false,
    );
  }

  @override
  List<Object?> get props =>
      [requestStatus, failure, data, skip, limit];
}
