import 'package:feature_folders_impl/src/folders_feature_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

import 'folders_component.dart';

@j.componentBuilder
abstract class IFoldersComponentBuilder {
  IFoldersComponentBuilder dependencies(
    FoldersFeatureDependencies dependencies,
  );

  IFoldersComponent build();
}
