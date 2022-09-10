import 'dart:async' show Future;

import 'package:flutter/services.dart' show rootBundle;
import 'package:localization_api/localization_api.dart';
import 'package:localization_impl/src/tg_strings_provider.dart';
import 'package:sprintf/sprintf.dart';
import 'package:xml/xml.dart';

class LocalizationManager implements ILocalizationManager {
  late Map<String, String> _defaultStrings;
  late Map<String, String> _currentStrings;
  late IStringsProvider _stringsProvider;

  @override
  Future<void> init(String defaultLanguage, String currentLanguage) async {
    _defaultStrings = await _readStrings(defaultLanguage);

    if (defaultLanguage == currentLanguage) {
      _currentStrings = _defaultStrings;
    } else {
      _currentStrings = await _readStrings(defaultLanguage);
    }
    _stringsProvider = TgStringsProvider(getString, getStringFormatted);
  }

  @override
  String getString(String key, [String defaultValue = '']) =>
      _currentStrings[key] ?? _defaultStrings[key] ?? defaultValue;

  @override
  String getStringFormatted(
    String key,
    List<dynamic> formatArgs, [
    String defaultValue = '',
  ]) {
    final String s =
        _currentStrings[key] ?? _defaultStrings[key] ?? defaultValue;
    return sprintf(s, formatArgs);
  }

  @override
  Future<void> setLanguage(String language) async {
    _currentStrings = await _readStrings(language);
  }

  Future<Map<String, String>> _readStrings(String language) async {
    final String rawXml = await rootBundle.loadString(
      'packages/localization_impl/assets/translations/$language.xml',
    );

    final XmlDocument document = XmlDocument.parse(rawXml);

    final Map<String, String> strings = <String, String>{};

    final XmlElement resNode = document.nodes
        .firstWhere((XmlNode node) => node is XmlElement) as XmlElement;

    final Iterable<XmlElement> stringNodes =
        resNode.nodes.whereType<XmlElement>();
    for (final XmlNode stringNode in stringNodes) {
      final XmlAttribute stringAttribute = stringNode.attributes[0];

      final String key = stringAttribute.value;
      assert(!strings.containsKey(key), 'duplicate string $key');
      strings[key] = stringNode.children[0].toString();
    }

    return strings;
  }

  @override
  IStringsProvider get stringsProvider {
    return _stringsProvider;
  }
}
