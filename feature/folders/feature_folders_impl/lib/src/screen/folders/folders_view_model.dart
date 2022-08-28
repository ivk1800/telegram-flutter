import 'package:core_arch/core_arch.dart';
import 'package:feature_folders_impl/src/di/scope/screen_scope.dart';

import 'package:jugger/jugger.dart' as j;
import 'folders_screen_router.dart';

@j.disposable
@screenScope
class FoldersViewModel extends BaseViewModel {
  @j.inject
  FoldersViewModel({
    required IFoldersScreenRouter router,
  }) : _router = router;

  final IFoldersScreenRouter _router;

  void onCreateNewFolderTap() => _router.toCreateNewFolder();
}
