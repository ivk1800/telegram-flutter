import 'package:core_arch/core_arch.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';

class SettingViewModel extends BaseViewModel {
  SettingViewModel({
    required ISettingsScreenRouter router,
  }) : _router = router;

  final ISettingsScreenRouter _router;

  void onLogOutTap() => _router.toLogOut();

  void onNotificationsSettingsTap() => _router.toNotificationsSettings();

  void onPrivacySettingsTap() => _router.toPrivacySettings();

  void onDataSettingsTap() => _router.toDataSettings();

  void onChatSettingsTap() => _router.toChatSettings();

  void onFoldersTap() => _router.toFolders();

  void onSessionsTap() => _router.toSessions();
}
