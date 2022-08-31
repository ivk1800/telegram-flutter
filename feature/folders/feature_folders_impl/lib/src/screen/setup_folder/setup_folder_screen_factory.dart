import 'package:feature_folders_api/feature_folders_api.dart';
import 'package:feature_folders_impl/src/di/folders_component.dart';
import 'package:feature_folders_impl/src/screen/setup_folder/setup_folder_page.dart';
import 'package:flutter/widgets.dart';

import 'setup_folder_screen_scope_delegate.scope.dart';

class SetupFolderScreenFactory implements ISetupFolderScreenFactory {
  SetupFolderScreenFactory({
    required IFoldersComponent foldersComponent,
  }) : _foldersComponent = foldersComponent;

  final IFoldersComponent _foldersComponent;

  @override
  Widget create() {
    return SetupFolderScreenScope(
      child: const SetupFolderPage(),
      create: _foldersComponent.createSetupFolderScreenComponent,
    );
  }
}
