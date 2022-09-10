import 'strings_provider.dart';

abstract class ILocalizationManager {
  Future<void> init(String defaultLanguage, String currentLanguage);

  String getString(String key, [String defaultValue = '']);

  String getStringFormatted(
    String key,
    List<dynamic> formatArgs, [
    String defaultValue = '',
  ]);

  Future<void> setLanguage(String language);

  IStringsProvider get stringsProvider;
}
