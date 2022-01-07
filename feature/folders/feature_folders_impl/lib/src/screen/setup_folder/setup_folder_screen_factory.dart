import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_folders_api/feature_folders_api.dart';
import 'package:feature_folders_impl/src/di/di.dart';
import 'package:flutter/widgets.dart';
import 'package:folders_presentation/folders_presentation.dart';
import 'package:folders_ui_common/folders_ui_common.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:provider_extensions/provider_extensions.dart';

class SetupFolderScreenFactory implements ISetupFolderScreenFactory {
  SetupFolderScreenFactory({
    required FoldersComponent foldersComponent,
  }) : _foldersComponent = foldersComponent;

  final FoldersComponent _foldersComponent;

  @override
  Widget create() {
    return Scope<SetupFolderScreenComponent>(
      create: () => JuggerSetupFolderScreenComponentBuilder()
          .foldersComponent(_foldersComponent)
          .build(),
      providers: (SetupFolderScreenComponent component) {
        return <Provider<dynamic>>[
          ViewModelProvider<SetupFolderViewModel>(
            create: (_) => component.getSetupFolderViewModel(),
          ),
          Provider<tg.TgAppBarFactory>(
            create: (_) => _foldersComponent.getTgAppBarFactory(),
          ),
          Provider<ILocalizationManager>(
            create: (_) => _foldersComponent.getLocalizationManager(),
          ),
        ];
      },
      child: const SetupFolderPage(),
    );
  }
}
