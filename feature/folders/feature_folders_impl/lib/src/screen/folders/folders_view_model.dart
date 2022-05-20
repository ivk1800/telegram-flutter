import 'package:core_arch/core_arch.dart';

import 'folders_screen_router.dart';

class FoldersViewModel extends BaseViewModel {
  FoldersViewModel({
    required IFoldersScreenRouter router,
  }) : _router = router;

  final IFoldersScreenRouter _router;

  void onCreateNewFolderTap() => _router.toCreateNewFolder();
}
