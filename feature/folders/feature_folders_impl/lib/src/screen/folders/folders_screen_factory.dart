import 'package:core_arch/core_arch.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_folders_api/feature_folders_api.dart';
import 'package:feature_folders_impl/src/di/di.dart';
import 'package:flutter/widgets.dart';
import 'package:folders_presentation/folders_presentation.dart';
import 'package:folders_ui_common/folders_ui_common.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:provider_extensions/provider_extensions.dart';

class FoldersScreenFactory implements IFoldersScreenFactory {
  FoldersScreenFactory({
    required FoldersComponent foldersComponent,
  }) : _foldersComponent = foldersComponent;

  final FoldersComponent _foldersComponent;

  @override
  Widget create() {
    return Scope<FoldersScreenComponent>(
      create: () => JuggerFoldersScreenComponentBuilder()
          .foldersComponent(_foldersComponent)
          .build(),
      providers: (FoldersScreenComponent component) {
        return <Provider<dynamic>>[
          ViewModelProvider<FoldersViewModel>(
            create: (_) => component.getFoldersViewModel(),
          ),
          Provider<tg.TgAppBarFactory>(
            create: (_) => _foldersComponent.getTgAppBarFactory(),
          ),
          Provider<ILocalizationManager>(
            create: (_) => _foldersComponent.getLocalizationManager(),
          ),
        ];
      },
      child: const FoldersPage(),
    );
  }
}
