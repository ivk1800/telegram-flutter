library localization_impl;

import 'dart:async' show Future;

import 'package:xml/xml.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:localization_api/localization_api.dart';

class LocalizationManager implements ILocalizationManager {
  late Map<String, String> _defaultStrings;
  late Map<String, String> _currentStrings;

  Future<void> init(String defaultLanguage, String currentLanguage) async {
    _defaultStrings = await _readStrings(defaultLanguage);

    if (defaultLanguage == currentLanguage) {
      _currentStrings = _defaultStrings;
    } else {
      _currentStrings = await _readStrings(defaultLanguage);
    }
  }

  @override
  String getString(String key, [String defaultValue = '']) =>
      _currentStrings[key] ?? _defaultStrings[key] ?? defaultValue;

  @override
  Future<void> setLanguage(String language) async {
    _currentStrings = await _readStrings(language);
  }

  Future<Map<String, String>> _readStrings(String language) async {
    final String rawXml = await rootBundle.loadString(
        'packages/localization_impl/assets/translations/$language.xml');

    final XmlDocument document = XmlDocument.parse(rawXml);

    final Map<String, String> strings = <String, String>{};

    final Iterable<XmlElement> nodes = document.nodes.whereType<XmlElement>();
    for (final XmlNode node in nodes) {
      final XmlAttribute stringAttribute = node.attributes[0];
      strings[stringAttribute.value] = node.children[0].toString();
    }

    return strings;
  }
}
