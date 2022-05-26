import 'folders_screen_factory.dart';
import 'setup_folder_screen_factory.dart';

abstract class IFoldersFeatureApi {
  IFoldersScreenFactory get foldersScreenFactory;

  ISetupFolderScreenFactory get setupFolderScreenFactory;
}
