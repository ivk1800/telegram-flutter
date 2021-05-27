import 'package:core_arch/core_arch.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:feature_data_settings_impl/src/data_settings_screen_router.dart';

class DataSettingsViewModel extends BaseViewModel {
  @j.inject
  DataSettingsViewModel({required IDataSettingsScreenRouter router})
      : _router = router;
  final IDataSettingsScreenRouter _router;
}
