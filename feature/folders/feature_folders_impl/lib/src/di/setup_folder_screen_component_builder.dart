import 'package:jugger/jugger.dart' as j;

import 'folders_component.dart';
import 'setup_folder_screen_component.dart';

@j.componentBuilder
abstract class ISetupFolderScreenComponentBuilder {
  ISetupFolderScreenComponentBuilder foldersComponent(
    IFoldersComponent foldersComponent,
  );

  ISetupFolderScreenComponent build();
}
