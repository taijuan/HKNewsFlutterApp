import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hknews/Home.dart';
import 'package:hknews/Welcome.dart';
import 'package:hknews/localization/HKNewsLocalizationsDelegate.dart';

void main() {
  return runApp(
    MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        HKNewsLocalizationsDelegate.delegate,
      ],
      locale: Locale("en", ""),
      supportedLocales: [
        Locale("zh", ""),
        Locale("en", ""),
      ],
      routes: {
        "/": (_) {
          return WelcomePage();
        },
        "HomePage": (_) {
          return HomePage();
        }
      },
    ),
  );
}
