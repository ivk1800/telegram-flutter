library feature_folders_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_folders_api/feature_folders_api.dart';
import 'package:localization_api/localization_api.dart';

import 'src/di/folders_component.dart';
import 'src/di/folders_component.jugger.dart';
import 'src/folders_router.dart';
import 'src/screen/folders/folders_screen_factory.dart';
import 'src/screen/setup_folder/setup_folder_screen_factory.dart';

export 'src/folders_router.dart';

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

class FoldersFeatureDependencies {
  const FoldersFeatureDependencies({
    required this.router,
    required this.connectionStateProvider,
    required this.stringsProvider,
  });

  final IFoldersRouter router;

  final IConnectionStateProvider connectionStateProvider;

  final IStringsProvider stringsProvider;
}
