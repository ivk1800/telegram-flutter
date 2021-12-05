import 'package:folders_presentation/folders_presentation.dart';

abstract class IFoldersRouter
    implements IFoldersScreenRouter, ISetupFolderScreenRouter {
  @override
  void toCreateNewFolder();
}
