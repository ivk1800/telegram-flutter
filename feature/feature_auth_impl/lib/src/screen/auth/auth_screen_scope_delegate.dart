import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:localization_api/localization_api.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';

import 'auth_screen_vidget_model.dart';
import 'view_model/auth_view_model.dart';

@scope
abstract class IAuthScreenScopeDelegate implements ScopeDisposer {
  AuthViewModel getAuthViewModel();

  IStringsProvider getStringsProvider();

  AuthScreenWidgetModel getAuthScreenWidgetModel();

  tg.TgAppBarFactory getTgAppBarFactory();
}
