import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hknews/localization/HKNewsStringBase.dart';
import 'package:hknews/localization/HKNewsStringEn.dart';
import 'package:hknews/localization/HKNewsStringZh.dart';

export 'package:hknews/localization/HKNewsLocalizations.dart';

///自定义多语言实现
class HKNewsLocalizations {
  final Locale locale;

  HKNewsLocalizations(this.locale);

  ///根据不同 locale.languageCode 加载不同语言对应
  ///GSYStringEn和GSYStringZh都继承了GSYStringBase
  static Map<String, HKNewsStringBase> _localizedValues = {
    'en': new HKNewsStringEn(),
    'zh': new HKNewsStringZh(),
  };

  HKNewsStringBase get currentLocalized {
    return _localizedValues[locale.languageCode];
  }

  ///通过 Localizations 加载当前的 GSYLocalizations
  ///获取对应的 GSYStringBase
  static HKNewsStringBase of(BuildContext context) {
    HKNewsLocalizations a = Localizations.of(context, HKNewsLocalizations);
    return a.currentLocalized;
  }
}
