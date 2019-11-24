import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../l10n/messages_all.dart';

class ConverterLocalizations {
  static Future<ConverterLocalizations> load(Locale locale) async {
    final String localeName =
        locale.countryCode == null || locale.countryCode.isNotEmpty
            ? locale.languageCode
            : locale.toString();

    final String canonicalLocaleName = Intl.canonicalizedLocale(localeName);

    return initializeMessages(canonicalLocaleName).then((bool _) {
      Intl.defaultLocale = canonicalLocaleName;
      return new ConverterLocalizations();
    });
  }

  static ConverterLocalizations of(BuildContext context) =>
      Localizations.of<ConverterLocalizations>(context, ConverterLocalizations);

  String get title => Intl.message(
        'Country Info Helper',
        name: 'title',
        desc: 'App title',
      );

  String get chooseCountry => Intl.message('Choose country:',
      name: 'chooseCountry', desc: 'User should pick a country.');

  String get currencyConverter => Intl.message(
        'Currency converter:',
        name: 'currencyConverter',
      );

  String get currentTime => Intl.message('Current time:', name: 'currentTime');
}
