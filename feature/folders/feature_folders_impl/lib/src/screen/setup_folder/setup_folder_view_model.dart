import 'package:core_arch/core_arch.dart';
import 'package:dialog_api/dialog_api.dart';
import 'package:feature_folders_impl/src/di/scope/screen_scope.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'setup_folder_screen_router.dart';

@j.disposable
@screenScope
class SetupFolderViewModel extends BaseViewModel {
  @j.inject
  SetupFolderViewModel({
    required ISetupFolderScreenRouter router,
    required IStringsProvider stringsProvider,
  })  : _router = router,
        _stringsProvider = stringsProvider;

  final ISetupFolderScreenRouter _router;
  final IStringsProvider _stringsProvider;

  void onRemoveFolderTap() {
    _router.toDialog(
      body: Body.text(
        text: _stringsProvider.filterDeleteAlert,
      ),
      title: _stringsProvider.filterDelete,
      actions: <Action>[
        Action(text: _stringsProvider.cancel),
        Action(
          text: _stringsProvider.delete,
          type: ActionType.attention,
          callback: (IDismissible dismissible) {
            _router.toNotImplemented();
            dismissible.dismiss();
          },
        ),
      ],
    );
  }
}
