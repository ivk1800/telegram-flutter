import 'package:core_arch/core_arch.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_main_screen_impl/src/screen/main/folders_interactor.dart';

import 'folder.dart';
import 'menu_item.dart';

class MainViewModel extends BaseViewModel {
  MainViewModel({
    required IMainScreenRouter router,
    required FoldersInteractor foldersInteractor,
  })  : _router = router,
        _foldersInteractor = foldersInteractor;

  final IMainScreenRouter _router;
  final FoldersInteractor _foldersInteractor;

  Stream<List<Folder>> get foldersStream => _foldersInteractor.foldersStream;

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

  void onNewMessageTap() {
    _router.toCreateNewChat();
  }
}
