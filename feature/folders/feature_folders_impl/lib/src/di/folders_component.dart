import 'package:core_ui_jugger/core_ui_jugger.dart';
import 'package:feature_folders_impl/src/di/scope/feature_scope.dart';
import 'package:feature_folders_impl/src/folders_feature_dependencies.dmg.dart';
import 'package:jugger/jugger.dart' as j;

import 'folders_component_builder.dart';
import 'folders_screen_component.dart';
import 'setup_folder_screen_component.dart';

@j.Component(
  modules: <Type>[
    FoldersFeatureDependenciesModule,
    TgAppBarModule,
  ],
  builder: IFoldersComponentBuilder,
)
@featureScope
abstract class IFoldersComponent {
  @j.subcomponentFactory
  ISetupFolderScreenComponent createSetupFolderScreenComponent();

  @j.subcomponentFactory
  IFoldersScreenComponent createFoldersScreenComponent();
}
