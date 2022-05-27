import 'package:coreui/coreui.dart' as tg;
import 'package:feature_folders_impl/src/folders_router.dart';
import 'package:feature_folders_impl/src/screen/folders/folders_screen_router.dart';
import 'package:feature_folders_impl/src/screen/folders/folders_view_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'folders_component.dart';

@j.Component(
  dependencies: <Type>[IFoldersComponent],
  modules: <Type>[FoldersScreenModule],
)
abstract class IFoldersScreenComponent {
  FoldersViewModel getFoldersViewModel();

  tg.TgAppBarFactory getTgAppBarFactory();

  IStringsProvider getStringsProvider();
}

@j.module
abstract class FoldersScreenModule {
  @j.singleton
  @j.provides
  static FoldersViewModel provideFoldersViewModel(
    IFoldersScreenRouter router,
  ) =>
      FoldersViewModel(router: router);

  @j.singleton
  @j.binds
  IFoldersScreenRouter bindFoldersScreenRouter(IFoldersRouter router);
}

@j.componentBuilder
abstract class IFoldersScreenComponentBuilder {
  IFoldersScreenComponentBuilder foldersComponent(
    IFoldersComponent foldersComponent,
  );

  IFoldersScreenComponent build();
}
