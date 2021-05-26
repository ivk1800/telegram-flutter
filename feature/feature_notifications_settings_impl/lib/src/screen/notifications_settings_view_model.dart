import 'package:core_arch/core_arch.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:feature_notifications_settings_impl/src/notifications_settings_screen_router.dart';

class NotificationsSettingsViewModel extends BaseViewModel {
  @j.inject
  NotificationsSettingsViewModel(
      {required INotificationsSettingsScreenRouter router})
      : _router = router;
  final INotificationsSettingsScreenRouter _router;
}
