import 'package:feature_folders_impl/feature_folders_impl.dart';
import 'package:feature_folders_impl/src/di/scope/screen_scope.dart';
import 'package:feature_folders_impl/src/folders_router.dart';
import 'package:feature_folders_impl/src/screen/setup_folder/setup_folder_screen_router.dart';
import 'package:feature_folders_impl/src/screen/setup_folder/setup_folder_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;

@j.Subcomponent(
  modules: <Type>[SetupFolderScreenModule],
)
@screenScope
abstract class ISetupFolderScreenComponent
    implements ISetupFolderScreenScopeDelegate {}

@j.module
abstract class SetupFolderScreenModule {
  @screenScope
  @j.binds
  ISetupFolderScreenRouter bindSetupFolderScreenRouter(IFoldersRouter router);
}
