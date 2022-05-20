import 'screen/folders/folders_screen_router.dart';
import 'screen/setup_folder/setup_folder_screen_router.dart';

abstract class IFoldersRouter
    implements IFoldersScreenRouter, ISetupFolderScreenRouter {
  @override
  void toCreateNewFolder();
}
