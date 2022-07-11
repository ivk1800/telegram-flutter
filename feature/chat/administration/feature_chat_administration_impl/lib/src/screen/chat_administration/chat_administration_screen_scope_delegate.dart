import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:localization_api/localization_api.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';

import 'chat_administration_view_model.dart';

@scope
abstract class IChatAdministrationScreenScopeDelegate implements ScopeDisposer {
  IStringsProvider getStringsProvider();

  ChatAdministrationViewModel getChatAdministrationViewModel();

  tg.TgAppBarFactory getTgAppBarFactory();
}
