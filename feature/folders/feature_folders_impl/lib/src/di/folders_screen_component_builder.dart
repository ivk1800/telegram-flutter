import 'package:jugger/jugger.dart' as j;

import 'folders_component.dart';
import 'folders_screen_component.dart';

@j.componentBuilder
abstract class IFoldersScreenComponentBuilder {
  IFoldersScreenComponentBuilder foldersComponent(
    IFoldersComponent foldersComponent,
  );

  IFoldersScreenComponent build();
}
