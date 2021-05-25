import 'package:core_arch/core_arch.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:feature_privacy_settings_impl/src/privacy_settings_screen_router.dart';

class PrivacySettingsViewModel extends BaseViewModel {
  @j.inject
  PrivacySettingsViewModel({required IPrivacySettingsScreenRouter router})
      : _router = router;
  final IPrivacySettingsScreenRouter _router;
}
