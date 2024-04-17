import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../enums/app_languages.dart';

/// Class [AppLocale] that handles localization logic in the app
class AppLocale {
  static AppLocale? _instance;
  AppLocale._();

  factory AppLocale() => _instance ??= AppLocale._();

  final Locale arabic =
      const Locale('ar', "SY"); // Represents the Arabic locale
  final Locale english =
      const Locale('en', "US"); // Represents the English locale

  // Returns the current language based on the context locale
  AppLanguages currentLanguage(BuildContext context) {
    //If the context locale is Arabic, return the Arabic language
    if (context.locale == arabic) return AppLanguages.arabic;

    return AppLanguages.english; // The default language is English,
  }

  // Returns a list of supported locales in the app, containing the English and Arabic locales
  List<Locale> get supportedLocaless => [english, arabic];

  // Changes the language based on the provided AppLanguages enum value
  void changeLangauge(BuildContext context, AppLanguages to) {
    Locale newLocal = context.locale; // Get the current locale from the context
    final current = currentLanguage(context); // Get the current language

    // If the current language is already the target language, return without making any changes
    if (current != to) return;

    // Switch the current language and set the new locale accordingly
    switch (current) {
      case AppLanguages.arabic:
        newLocal = english;
        break;
      case AppLanguages.english:
        newLocal = arabic;
        break;
    }

    // Set the new locale using the `setLocale` method provided by Easy Localization
    context.setLocale(newLocal);
  }

  // Checks if the current language is English
  bool isEnglish(BuildContext context) =>
      currentLanguage(context) == AppLanguages.english;

  // Checks if the current language is Arabic
  bool isArabic(BuildContext context) =>
      currentLanguage(context) == AppLanguages.arabic;
}
