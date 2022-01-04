library localization_api;

abstract class ILocalizationManager {
  String getString(String key, [String defaultValue = '']);

  String getStringFormatted(
    String key,
    List<dynamic> formatArgs, [
    String defaultValue = '',
  ]);

  Future<void> setLanguage(String language);
}
