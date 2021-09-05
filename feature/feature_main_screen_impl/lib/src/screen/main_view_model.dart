import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_main_screen_impl/src/screen/menu_item.dart';
import 'package:jugger/jugger.dart' as j;

class MainViewModel implements j.IDisposable {
  @j.inject
  MainViewModel(IMainScreenRouter router) : _router = router;

  final IMainScreenRouter _router;

  void onMenuItemTap(MenuItem item) {
    switch (item) {
      case MenuItem.settings:
        _router.toSettings();
        break;
      case MenuItem.dev:
        _router.toDev();
        break;
    }
  }

  @override
  void dispose() {}
}
