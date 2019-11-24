import 'dart:async';

import 'package:flutter/material.dart';
import 'converter_localizations.dart';

class ConverterLocalizationsDelegate
    extends LocalizationsDelegate<ConverterLocalizations> {
  const ConverterLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar', 'pt', 'jp'].contains(locale.languageCode);

  @override
  Future<ConverterLocalizations> load(Locale locale) =>
      ConverterLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<ConverterLocalizations> old) => false;
}
