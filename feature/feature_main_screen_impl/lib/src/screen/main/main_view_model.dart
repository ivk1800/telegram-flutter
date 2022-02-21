import 'package:core_arch/core_arch.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';

import 'menu_item.dart';

class MainViewModel extends BaseViewModel {
  MainViewModel({
    required IMainScreenRouter router,
  }) : _router = router;

  final IMainScreenRouter _router;

  void onMenuItemTap(MenuItem item) {
    switch (item) {
      case MenuItem.settings:
        _router.toSettings();
        break;
      case MenuItem.dev:
        _router.toDev();
        break;
      case MenuItem.contacts:
        _router.toContacts();
        break;
    }
  }
}
