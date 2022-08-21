import 'package:coreui/coreui.dart' as tg;
import 'package:feature_folders_impl/feature_folders_impl.dart';
import 'package:feature_folders_impl/src/folders_router.dart';
import 'package:feature_folders_impl/src/screen/setup_folder/setup_folder_screen_router.dart';
import 'package:feature_folders_impl/src/screen/setup_folder/setup_folder_view_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'folders_component.dart';
import 'setup_folder_screen_component_builder.dart';

@j.Component(
  dependencies: <Type>[IFoldersComponent],
  modules: <Type>[SetupFolderScreenModule],
  builder: ISetupFolderScreenComponentBuilder,
)
@j.singleton
abstract class ISetupFolderScreenComponent {
  SetupFolderViewModel getSetupFolderViewModel();

  tg.TgAppBarFactory getTgAppBarFactory();

  IStringsProvider getStringsProvider();
}

@j.module
abstract class SetupFolderScreenModule {
  @j.singleton
  @j.provides
  static SetupFolderViewModel provideSetupFolderViewModel(
    IStringsProvider stringsProvider,
    ISetupFolderScreenRouter router,
  ) =>
      SetupFolderViewModel(
        router: router,
        stringsProvider: stringsProvider,
      );

  @j.singleton
  @j.binds
  ISetupFolderScreenRouter bindSetupFolderScreenRouter(IFoldersRouter router);
}
