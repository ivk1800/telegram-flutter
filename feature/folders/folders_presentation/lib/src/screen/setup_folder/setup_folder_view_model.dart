import 'package:core_arch/core_arch.dart';

import 'setup_folder_screen_router.dart';

class SetupFolderViewModel extends BaseViewModel {
  SetupFolderViewModel({
    required ISetupFolderScreenRouter router,
  }) : _router = router;

  final ISetupFolderScreenRouter _router;
}
