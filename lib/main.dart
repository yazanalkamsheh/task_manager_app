import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:base_project_v2/core/routes/app_routes.dart';
import 'package:base_project_v2/core/services/cache_storage_services.dart';
import 'package:base_project_v2/core/services/service_locator.dart';
import 'package:base_project_v2/core/themes/app_theme.dart';
import 'package:base_project_v2/core/translations/app_local.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheStorageServices.init();
  ServicesLocator().init();
  await EasyLocalization.ensureInitialized();

  // set up easy_localization lib
  runApp(
    EasyLocalization(
      supportedLocales: AppLocale().supportedLocaless,
      fallbackLocale: AppLocale().english,
      path: 'resources/langs',
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return Sizer Builder
    return Sizer(builder: (context, orientation, deviceType) {
      return AdaptiveTheme(
        light: AppTheme().lightTheme,
        dark: AppTheme().darkTheme,
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Task Manager App',
          theme: theme,
          darkTheme: darkTheme,
          routerConfig: AppRoutes.router,
        ),
      );
    });
  }
}
