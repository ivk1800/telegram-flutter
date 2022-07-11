import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:localization_api/localization_api.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';

import 'new_contact_view_model.dart';
import 'new_contact_widget_model.dart';

@scope
abstract class INewContactScreenScopeDelegate implements ScopeDisposer {
  IStringsProvider getStringsProvider();

  NewContactViewModel getNewContactViewModel();

  NewContactWidgetModel getNewContactWidgetModel();

  tg.AvatarWidgetFactory getAvatarWidgetFactory();

  tg.TgAppBarFactory getTgAppBarFactory();
}
