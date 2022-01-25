library localization_api;

import 'src/strings_provider.dart';

export 'src/strings_provider.dart';

abstract class ILocalizationManager {
  String getString(String key, [String defaultValue = '']);

  String getStringFormatted(
    String key,
    List<dynamic> formatArgs, [
    String defaultValue = '',
  ]);

  Future<void> setLanguage(String language);

  IStringsProvider get stringsProvider;
}
