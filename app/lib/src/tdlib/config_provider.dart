import 'dart:convert';

import 'package:app_controller/app_controller_component.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jugger/jugger.dart' as j;

class TdConfigProvider implements ITdConfigProvider {
  @j.inject
  TdConfigProvider();

  Future<Map<String, String>>? _cache;

  @override
  Future<int> getAppId() async =>
      int.parse((await (_cache ??= _readFromAssets()))['apiId']!);

  @override
  Future<String> getApiHash() async =>
      (await (_cache ??= _readFromAssets()))['apiHash']!;

  @override
  Future<String> getEncryptionKey() async =>
      (await (_cache ??= _readFromAssets()))['encryptionKey']!;

  Future<Map<String, String>> _readFromAssets() async {
    final String raw =
        await rootBundle.loadString('packages/app/assets/tdlib/config.txt');

    final List<MapEntry<String, String>> entries = LineSplitter.split(raw)
        .where((String line) => line.isNotEmpty)
        .map((String line) {
      final List<String> parts = line.split(':');
      final String key = parts[0];
      final String value = parts[1];

      return MapEntry<String, String>(key, value);
    }).toList();

    return Map<String, String>.fromEntries(entries);
  }
}
