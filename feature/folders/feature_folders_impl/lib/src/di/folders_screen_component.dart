import 'package:feature_folders_impl/src/di/scope/screen_scope.dart';
import 'package:feature_folders_impl/src/folders_router.dart';
import 'package:feature_folders_impl/src/screen/folders/folders_screen_router.dart';
import 'package:feature_folders_impl/src/screen/folders/folders_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;

@j.Subcomponent(
  modules: <Type>[FoldersScreenModule],
)
@screenScope
abstract class IFoldersScreenComponent implements IFoldersScreenScopeDelegate {}

@j.module
abstract class FoldersScreenModule {
  @screenScope
  @j.binds
  IFoldersScreenRouter bindFoldersScreenRouter(IFoldersRouter router);
}
