import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hknews/localization/HKNewsLocalizations.dart';

export 'package:hknews/localization/HKNewsLocalizationsDelegate.dart';

class HKNewsLocalizationsDelegate
    extends LocalizationsDelegate<HKNewsLocalizations> {
  HKNewsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    ///支持中文和英语
    return ['en', 'zh'].contains(locale.languageCode);
  }

  ///根据locale，创建一个对象用于提供当前locale下的文本显示
  @override
  Future<HKNewsLocalizations> load(Locale locale) {
    return new SynchronousFuture<HKNewsLocalizations>(
        new HKNewsLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<HKNewsLocalizations> old) {
    return false;
  }

  ///全局静态的代理
  static HKNewsLocalizationsDelegate delegate =
      new HKNewsLocalizationsDelegate();
}
