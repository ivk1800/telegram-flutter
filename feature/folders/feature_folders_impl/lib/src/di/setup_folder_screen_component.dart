import 'package:feature_folders_impl/src/folders_router.dart';
import 'package:folders_presentation/folders_presentation.dart';
import 'package:jugger/jugger.dart' as j;

import 'folders_component.dart';

@j.Component(
  dependencies: <Type>[FoldersComponent],
  modules: <Type>[SetupFolderScreenModule],
)
abstract class SetupFolderScreenComponent {
  SetupFolderViewModel getSetupFolderViewModel();
}

@j.module
abstract class SetupFolderScreenModule {
  @j.singleton
  @j.provide
  static SetupFolderViewModel provideSetupFolderViewModel(
    ISetupFolderScreenRouter router,
  ) =>
      SetupFolderViewModel(router: router);

  @j.singleton
  @j.provide
  // todo bind not work from FoldersComponent
  static ISetupFolderScreenRouter provideSetupFolderScreenRouter(
    IFoldersRouter router,
  ) =>
      router;
}

@j.componentBuilder
abstract class SetupFolderScreenComponentBuilder {
  SetupFolderScreenComponentBuilder foldersComponent(
    FoldersComponent foldersComponent,
  );

  SetupFolderScreenComponent build();
}
