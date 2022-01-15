import 'package:feature_folders_impl/src/folders_router.dart';
import 'package:folders_presentation/folders_presentation.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'folders_component.dart';

@j.Component(
  dependencies: <Type>[IFoldersComponent],
  modules: <Type>[SetupFolderScreenModule],
)
abstract class ISetupFolderScreenComponent {
  SetupFolderViewModel getSetupFolderViewModel();
}

@j.module
abstract class SetupFolderScreenModule {
  @j.singleton
  @j.provides
  static SetupFolderViewModel provideSetupFolderViewModel(
    ILocalizationManager localizationManager,
    ISetupFolderScreenRouter router,
  ) =>
      SetupFolderViewModel(
        router: router,
        localizationManager: localizationManager,
      )..init();

  @j.singleton
  @j.binds
  ISetupFolderScreenRouter bindSetupFolderScreenRouter(IFoldersRouter router);
}

@j.componentBuilder
abstract class ISetupFolderScreenComponentBuilder {
  ISetupFolderScreenComponentBuilder foldersComponent(
    IFoldersComponent foldersComponent,
  );

  ISetupFolderScreenComponent build();
}
