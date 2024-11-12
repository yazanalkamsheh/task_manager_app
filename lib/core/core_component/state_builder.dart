import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project_v2/core/errors/failure.dart';
import 'package:base_project_v2/core/utils/base_state.dart';
import 'package:base_project_v2/core/utils/base_pagination_bloc/pagination_state.dart';

/// The [StateBuilder] widget provides a streamlined approach to handle various states within a Flutter application,
/// particularly when using the BLoC (Business Logic Component) pattern for state management.
///
/// This widget facilitates handling states such as loading, error, and success, and it's intended to be used
/// alongside BLoC components and [BaseState] implementations.
///
/// [StateBuilder] takes three main parameters:
///
/// 1- [onFailure]:
///    A callback function that is invoked when the state indicates an error. It typically displays
///    an error message or widget based on the provided [Failure] instance.
///
/// 2- [onLoading]:
///    A callback function that is called when the state indicates a loading state. It's responsible for
///    displaying a loading indicator or widget.
///
/// 3- [onSuccess]:
///    A callback function that is invoked when the state indicates a successful state. It's responsible
///    for rendering UI based on the retrieved data. This function receives a [BuildContext], the retrieved
///    data (of type `dynamic`), and a boolean flag indicating if the data has reached its maximum limit.
///
/// Usage example:
/// ```dart
/// StateBuilder(
///   onFailure: (failure) {
///     // Handle error state
///   },
///   onLoading: () {
///     // Show loading indicator
///   },
///   onSuccess: (context, data, hasReachMax) {
///     // Render UI based on retrieved data
///   },
/// )
/// ```
///
/// In the provided callbacks, if the state corresponds to a specific scenario, the respective callback
/// function is invoked, allowing for customized behavior depending on the current application state.
///
/// Note: This widget relies on the state provided by a BLoC component, hence it should be placed
/// within a [BlocBuilder] widget to ensure it rebuilds appropriately based on state changes.


class StateBuilder<B extends StateStreamable<S>, S extends BaseState>
    extends StatelessWidget {
  final Widget Function(BuildContext context,Failure failure)? onFailure;
  final Widget Function() onLoading;
  final Function(BuildContext context,dynamic data, bool hasReachMax) onSuccess;

  const StateBuilder({
    super.key,
    this.onFailure,
    required this.onLoading,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        if (state.isLoading) {
          // Return a loading indicator or widget
          return onLoading();
        } else if (state.isError && onFailure != null) {
          // Return an error message or widget
          return SizedBox(child: onFailure!(context,state.failure));
        } else if (state.isSuccess) {
          // Return your data UI
          if (state is PaginationState) {
            // Wrap the PaginatedListView in a SizedBox to ensure it matches the expected function signature
            return SizedBox(
                child: onSuccess(context, state.data, state.hasReachMax));
          } else {
            // For BaseState, assume hasReachMax as false
            return SizedBox(
              child: onSuccess(context ,state.data, false),
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
