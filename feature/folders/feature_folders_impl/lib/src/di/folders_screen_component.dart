import 'package:feature_folders_impl/src/folders_router.dart';
import 'package:folders_presentation/folders_presentation.dart';
import 'package:jugger/jugger.dart' as j;

import 'folders_component.dart';

@j.Component(
  dependencies: <Type>[FoldersComponent],
  modules: <Type>[FoldersScreenModule],
)
abstract class FoldersScreenComponent {
  FoldersViewModel getFoldersViewModel();
}

@j.module
abstract class FoldersScreenModule {
  @j.singleton
  @j.provides
  static FoldersViewModel provideFoldersViewModel(
    IFoldersScreenRouter router,
  ) =>
      FoldersViewModel(router: router)..init();

  @j.singleton
  @j.binds
  IFoldersScreenRouter bindFoldersScreenRouter(IFoldersRouter router);
}

@j.componentBuilder
abstract class FoldersScreenComponentBuilder {
  FoldersScreenComponentBuilder foldersComponent(
    FoldersComponent foldersComponent,
  );

  FoldersScreenComponent build();
}
