import 'package:base_project_v2/core/constants/app_colors.dart';
import 'package:base_project_v2/core/constants/app_shadow.dart';
import 'package:base_project_v2/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

extension TaskComponentTheme on ThemeData {
  BoxDecoration taskDecoration(context) {
    return BoxDecoration(
      color:AppTheme().isLight(context) ? AppColors.white : AppColors.green.withOpacity(0.7),
      border: Border.all(width: 1, color: AppColors.darkGrey),
      boxShadow: [AppShadows.normalShadow],
      borderRadius: BorderRadius.circular(10),
    );
  }
}
