library localization_api;

abstract class ILocalizationManager {
  String getString(String key, [String defaultValue = '']);

  Future<void> setLanguage(String language);
}
