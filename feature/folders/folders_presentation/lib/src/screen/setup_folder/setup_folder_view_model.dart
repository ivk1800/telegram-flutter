import 'package:core_arch/core_arch.dart';
import 'package:dialog_api/dialog_api.dart';
import 'package:localization_api/localization_api.dart';

import 'setup_folder_screen_router.dart';

class SetupFolderViewModel extends BaseViewModel {
  SetupFolderViewModel({
    required ISetupFolderScreenRouter router,
    required ILocalizationManager localizationManager,
  })  : _router = router,
        _localizationManager = localizationManager;

  final ISetupFolderScreenRouter _router;
  final ILocalizationManager _localizationManager;

  void onRemoveFolderTap() {
    _router.toDialog(
        body: TextBody(
          text: _localizationManager.getString('FilterDeleteAlert'),
        ),
        title: _localizationManager.getString('FilterDelete'),
        actions: <Action>[
          Action(text: _localizationManager.getString('Cancel')),
          Action(
            text: _localizationManager.getString('Delete'),
            type: ActionType.attention,
            callback: () {
              _router.toNotImplemented();
              return true;
            },
          ),
        ]);
  }
}
