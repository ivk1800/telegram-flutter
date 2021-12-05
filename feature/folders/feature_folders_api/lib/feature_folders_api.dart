library feature_folders_api;

import 'package:flutter/widgets.dart';

abstract class IFoldersFeatureApi {
  IFoldersScreenFactory get foldersScreenFactory;

  ISetupFolderScreenFactory get setupFolderScreenFactory;
}

abstract class IFoldersScreenFactory {
  Widget create();
}

abstract class ISetupFolderScreenFactory {
  Widget create();
}
