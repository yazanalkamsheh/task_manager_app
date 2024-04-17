import 'package:base_project_v2/core/constants/app_colors.dart';
import 'package:base_project_v2/core/enums/app_languages.dart';
import 'package:base_project_v2/core/services/cache_storage_services.dart';
import 'package:base_project_v2/core/themes/app_theme.dart';
import 'package:base_project_v2/core/translations/app_local.dart';
import 'package:base_project_v2/generated/locale_keys.g.dart';
import 'package:base_project_v2/modules/auth/presentation/routes/login_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../routes/task_route.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: ListView(
        padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 5.w),
        children: [
          SizedBox(height: 15.w),
          _buildThemeComponent(context),
          SizedBox(height: 6.w),
          _buildLangaugeComponent(context),
          SizedBox(height: 6.w),
          _buildLogoutComponent(context),
        ],
      )),
    );
  }

  Widget _buildThemeComponent(BuildContext context) => Row(
        children: [
          const Icon(Icons.dark_mode_outlined),
          SizedBox(width: 2.w),
          TextButton(
            onPressed: () => AppTheme().changeTheme(context),
            child: Text(
              AppTheme().isLight(context)
                  ? LocaleKeys.darkMode.tr(context: context)
                  : LocaleKeys.lightMode.tr(context: context),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )
        ],
      );

  Widget _buildLogoutComponent(BuildContext context) => Row(
        children: [
          const Icon(Icons.logout),
          SizedBox(width: 3.w),
          TextButton(
            onPressed: () => _logout(context),
            child: Text(
              LocaleKeys.logout.tr(context: context),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.red),
            ),
          )
        ],
      );
}

void _logout(BuildContext context) async {
  await CacheStorageServices().removeToken();
  Future.delayed(
    Duration.zero,
    () => context.go(LoginRoute.name),
  );
}

Widget _buildLangaugeComponent(BuildContext context) => Row(
      children: [
        const Icon(Icons.translate),
        SizedBox(width: 2.w),
        TextButton(
          onPressed: () =>
              AppLocale().changeLangauge(context, AppLanguages.english),
          child: Text(
            LocaleKeys.arabic.tr(context: context),
            style: AppLocale().isArabic(context)
                ? Theme.of(context).textTheme.displaySmall
                : Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Text(
            "/",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        TextButton(
          onPressed: () =>
              AppLocale().changeLangauge(context, AppLanguages.arabic),
          child: Text(
            LocaleKeys.english.tr(context: context),
            style: AppLocale().isEnglish(context)
                ? Theme.of(context).textTheme.displaySmall
                : Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
