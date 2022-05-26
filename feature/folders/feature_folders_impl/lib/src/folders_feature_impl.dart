import 'package:feature_folders_api/feature_folders_api.dart';

import 'di/folders_component.dart';
import 'di/folders_component.jugger.dart';
import 'folders_feature_dependencies.dart';
import 'screen/folders/folders_screen_factory.dart';
import 'screen/setup_folder/setup_folder_screen_factory.dart';

class FoldersFeatureImpl implements IFoldersFeatureApi {
  FoldersFeatureImpl({
    required FoldersFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final FoldersFeatureDependencies _dependencies;

  late final FoldersScreenFactory _foldersScreenFactory =
      FoldersScreenFactory(foldersComponent: _foldersComponent);
  late final ISetupFolderScreenFactory _setupFolderScreenFactory =
      SetupFolderScreenFactory(
    foldersComponent: _foldersComponent,
  );

  late final IFoldersComponent _component =
      JuggerFoldersComponentBuilder().dependencies(_dependencies).build();

  IFoldersComponent get _foldersComponent => _component;

  @override
  IFoldersScreenFactory get foldersScreenFactory => _foldersScreenFactory;

  @override
  ISetupFolderScreenFactory get setupFolderScreenFactory =>
      _setupFolderScreenFactory;
}
