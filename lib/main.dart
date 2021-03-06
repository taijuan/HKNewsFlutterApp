import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hknews/Home.dart';
import 'package:hknews/Welcome.dart';
import 'package:hknews/localization/HKNewsLocalizationsDelegate.dart';

void main() {
  const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );
  SystemChrome.setSystemUIOverlayStyle(dark);
  return runApp(
    MaterialApp(
      theme: ThemeData(platform: TargetPlatform.iOS),
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
