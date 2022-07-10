import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:localization_api/localization_api.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';

import 'change_username_screen_widget_model.dart';
import 'change_username_view_model.dart';

@scope
abstract class IChangeUsernameScreenScopeDelegate implements ScopeDisposer {
  IStringsProvider getStringsProvider();

  tg.TgAppBarFactory getTgAppBarFactory();

  ChangeUsernameScreenWidgetModel getChangeUsernameScreenWidgetModel();

  ChangeUsernameViewModel getChangeUsernameViewModel();
}
