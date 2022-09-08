import 'package:core_arch/core_arch.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_main_screen_impl/src/screen/main/folders_interactor.dart';
import 'package:jugger/jugger.dart' as j;

import 'folder.dart';
import 'menu_item.dart';

@j.singleton
@j.disposable
class MainViewModel extends BaseViewModel {
  @j.inject
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
      case MenuItem.savedMessages:
        _router.toSavedMessages();
        break;
    }
  }

  void onNewMessageTap() {
    _router.toCreateNewChat();
  }
}
