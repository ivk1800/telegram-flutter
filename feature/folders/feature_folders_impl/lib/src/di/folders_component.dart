import 'package:coreui/coreui.dart' as tg;
import 'package:feature_folders_impl/feature_folders_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'folders_component_builder.dart';

@j.Component(
  modules: <Type>[FoldersModule],
  builder: IFoldersComponentBuilder,
)
@j.singleton
abstract class IFoldersComponent {
  tg.TgAppBarFactory getTgAppBarFactory();

  IFoldersRouter getFoldersRouter();

  IStringsProvider getStringsProvider();
}

@j.module
abstract class FoldersModule {
  @j.singleton
  @j.provides
  static tg.TgAppBarFactory provideTgAppBarFactory(
    FoldersFeatureDependencies dependencies,
  ) =>
      tg.TgAppBarFactory(
        connectionStateWidgetFactory: tg.ConnectionStateWidgetFactory(
          connectionStateProvider: dependencies.connectionStateProvider,
        ),
      );

  @j.singleton
  @j.provides
  static IStringsProvider provideStringsProvider(
    FoldersFeatureDependencies dependencies,
  ) =>
      dependencies.stringsProvider;

  @j.singleton
  @j.provides
  static IFoldersRouter provideFoldersRouter(
    FoldersFeatureDependencies dependencies,
  ) =>
      dependencies.router;
}
