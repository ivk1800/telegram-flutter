import 'package:feature_folders_api/feature_folders_api.dart';
import 'package:feature_folders_impl/src/di/folders_component.dart';
import 'package:feature_folders_impl/src/di/folders_screen_component.jugger.dart';
import 'package:flutter/widgets.dart';

import 'folders_page.dart';
import 'folders_screen_scope.dart';

class FoldersScreenFactory implements IFoldersScreenFactory {
  FoldersScreenFactory({
    required IFoldersComponent foldersComponent,
  }) : _foldersComponent = foldersComponent;

  final IFoldersComponent _foldersComponent;

  @override
  Widget create() {
    return FoldersScreenScope(
      child: const FoldersPage(),
      create: () => JuggerFoldersScreenComponentBuilder()
          .foldersComponent(_foldersComponent)
          .build(),
    );
  }
}
