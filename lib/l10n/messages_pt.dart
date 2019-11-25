// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pt';

  static m0(dest, currencyCode, local) => "Hoje, ${dest} (${currencyCode}) é equivalente a ${local} (BRL).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "chooseCountry" : MessageLookupByLibrary.simpleMessage("Selecione um país:"),
    "currencyConverter" : MessageLookupByLibrary.simpleMessage("Conversor de moedas:"),
    "currencyExchange" : m0,
    "currentTime" : MessageLookupByLibrary.simpleMessage("Hora atual:"),
    "failedLoadCurrency" : MessageLookupByLibrary.simpleMessage("Não foi possível carregar a moeda."),
    "failedLoadData" : MessageLookupByLibrary.simpleMessage("Não foi possível carregar informações sobre o país."),
    "title" : MessageLookupByLibrary.simpleMessage("Auxiliar de Informações do País")
  };
}
