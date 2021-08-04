import 'dart:convert';

import 'package:feature_country_api/feature_country_api.dart';
import 'package:flutter/services.dart' show rootBundle;

class CountryRepository {
  const CountryRepository();

  Future<List<Country>> getCountries() => _readFromAssets();

  Future<List<Country>> _readFromAssets() async {
    final String raw = await rootBundle
        .loadString('packages/feature_country_impl/assets/countries.txt');

    return LineSplitter.split(raw).map((String line) {
      final List<String> parts = line.split(';');
      final int code = int.parse(parts[0]);
      final String name = parts[2];
      final String? phoneFormat;
      if (parts.length > 3) {
        phoneFormat = parts[3];
      } else {
        phoneFormat = null;
      }

      return Country(
        name: name,
        code: code,
        phoneFormat: phoneFormat,
      );
    }).toList()
      ..sort((Country a, Country b) => a.name.compareTo(b.name));
  }
}
