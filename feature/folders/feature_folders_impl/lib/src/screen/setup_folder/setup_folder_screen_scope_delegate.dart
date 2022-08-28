import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:localization_api/localization_api.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';

import 'setup_folder_view_model.dart';

@scope
abstract class ISetupFolderScreenScopeDelegate implements ScopeDisposer {
  SetupFolderViewModel getSetupFolderViewModel();

  tg.TgAppBarFactory getTgAppBarFactory();

  IStringsProvider getStringsProvider();
}
