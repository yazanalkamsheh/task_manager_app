/// This file contains a set of components for displaying different types of failures in a Flutter application.
/// Each failure type has its own corresponding component that handles the visual representation of the failure.

import 'package:base_project_v2/core/errors/failure.dart';
import 'package:base_project_v2/core/services/service_locator.dart';
import 'package:base_project_v2/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_colors.dart';

/// The [FailureComponent] class is a generic component that takes a [Failure] object and dynamically selects the appropriate
/// sub-component based on the runtime type of the failure. It uses a switch statement to determine the failure type and
/// returns the corresponding component for that type.
///

// TODO: customize failure Components view

class FailureComponent extends StatelessWidget {
  const FailureComponent({super.key, required this.failure, this.onTryAgain});

  final void Function()? onTryAgain;
  final Failure failure;

  @override
  Widget build(BuildContext context) {
    logger.d(
        "============== build failure ================= \n ${failure.runtimeType.toString()}");

    switch (failure.runtimeType) {
      /// NoInternetFailureComponent handles the case when there is no internet connectivity.
      case NoInternetFailure:
        return NoInternetFailureComponent(
            failure: failure as NoInternetFailure, onTryAgain: onTryAgain);

      /// ServerFailureComponent handles the case when there is a failure related to the server.
      case ServerFailure:
        return ServerFailureComponent(
          failure: failure as ServerFailure,
          onTryAgain: onTryAgain,
        );

      /// UnknownFailureComponent handles the case when an unknown failure occurs.
      case UnknownFailure:
        return UnknownFailureComponent(
            failure: failure as UnknownFailure, onTryAgain: onTryAgain);

      /// ForceUpdateFailureComponent handles the case when the app requires an update.
      case ForceUpdateFailure:
        return ForceUpdateFailureComponent(
            failure: failure as ForceUpdateFailure);

      /// AppUnderMaintenanceFailureComponent handles the case when the app is under maintenance.
      case AppUnderMaintenanceFailure:
        return AppUnderMaintenanceFailureComponent(
            failure: failure as AppUnderMaintenanceFailure);

      /// SessionExpiredFailureComponent handles the case when the session has expired due to inactivity.
      case SessionExpiredFailure:
        return SessionExpiredFailureComponent(
            failure: failure as SessionExpiredFailure);

      /// ParsingFailureComponent handles the case when there is a failure in parsing the response.
      case ParsingFailure:
        return ParsingFailureComponent(failure: failure as ParsingFailure);

      /// Placeholder is a generic component used when the failure type is not recognized.
      default:
        return const Placeholder();
    }
  }
}

/// The [NoInternetFailureComponent] handles the visual representation of the NoInternetFailure type.
///
class NoInternetFailureComponent extends StatelessWidget {
  const NoInternetFailureComponent(
      {super.key, required this.failure, this.onTryAgain});

  final void Function()? onTryAgain;
  final NoInternetFailure failure;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            failure.message,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 2.w),
          if (onTryAgain != null) SizedBox(height: 3.w),
          if (onTryAgain != null)
            ElevatedButton(
              onPressed: onTryAgain,
              style: ButtonStyle(
                mouseCursor:
                    MaterialStateProperty.all(SystemMouseCursors.basic),
                elevation: MaterialStateProperty.all(2.0),
                backgroundColor: AppColors.colorProperty(AppColors.white),
                overlayColor:
                    AppColors.colorProperty(AppColors.green.withOpacity(0.1)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(8),
                    side: const BorderSide(
                      color: AppColors.green,
                    ),
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.tryAgain.tr(context: context),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.green),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  const Icon(
                    Icons.refresh,
                    color: AppColors.green,
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// The [ServerFailureComponent] handles the visual representation of the ServerFailure type.
///
class ServerFailureComponent extends StatelessWidget {
  const ServerFailureComponent(
      {super.key, required this.failure, this.onTryAgain});

  final void Function()? onTryAgain;
  final ServerFailure failure;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            failure.toString(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 3.w),
          if (onTryAgain != null)
            ElevatedButton(
              onPressed: onTryAgain,
              style: ButtonStyle(
                mouseCursor:
                    MaterialStateProperty.all(SystemMouseCursors.basic),
                elevation: MaterialStateProperty.all(2.0),
                backgroundColor: AppColors.colorProperty(AppColors.white),
                overlayColor:
                    AppColors.colorProperty(AppColors.green.withOpacity(0.1)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(8),
                    side: const BorderSide(
                      color: AppColors.green,
                    ),
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.tryAgain.tr(context: context),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.green),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  const Icon(
                    Icons.refresh,
                    color: AppColors.green,
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// The [UnknownFailureComponent] handles the visual representation of the UnknownFailure type.
///
class UnknownFailureComponent extends StatelessWidget {
  const UnknownFailureComponent(
      {super.key, required this.failure, this.onTryAgain});

  final void Function()? onTryAgain;
  final UnknownFailure failure;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            failure.message,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 3.w),
          if (onTryAgain != null)
            ElevatedButton(
              onPressed: onTryAgain,
              style: ButtonStyle(
                mouseCursor:
                    MaterialStateProperty.all(SystemMouseCursors.basic),
                elevation: MaterialStateProperty.all(2.0),
                backgroundColor: AppColors.colorProperty(AppColors.white),
                overlayColor:
                    AppColors.colorProperty(AppColors.green.withOpacity(0.1)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(8),
                    side: const BorderSide(
                      color: AppColors.green,
                    ),
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.tryAgain.tr(context: context),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.green),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  const Icon(
                    Icons.refresh,
                    color: AppColors.green,
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// The [ForceUpdateFailureComponent] handles the visual representation of the ForceUpdateFailure type.
///
class ForceUpdateFailureComponent extends StatelessWidget {
  const ForceUpdateFailureComponent({super.key, required this.failure});

  final ForceUpdateFailure failure;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        failure.message,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

/// The [AppUnderMaintenanceFailureComponent] handles the visual representation of the AppUnderMaintenanceFailure type.
///
class AppUnderMaintenanceFailureComponent extends StatelessWidget {
  const AppUnderMaintenanceFailureComponent({super.key, required this.failure});

  final AppUnderMaintenanceFailure failure;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        failure.message,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

/// The [SessionExpiredFailureComponent] handles the visual representation of the SessionExpiredFailure type.
///
class SessionExpiredFailureComponent extends StatelessWidget {
  const SessionExpiredFailureComponent({super.key, required this.failure});

  final SessionExpiredFailure failure;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        failure.message,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

/// The [ParsingFailureComponent] handles the visual representation of the ParsingFailure type.
///
class ParsingFailureComponent extends StatelessWidget {
  const ParsingFailureComponent({super.key, required this.failure});

  final ParsingFailure failure;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        failure.toString(),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
