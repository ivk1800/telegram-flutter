import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:localization_api/localization_api.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';

import 'header_view_model.dart';
import 'main_screen_widget_model.dart';
import 'main_view_model.dart';

@scope
abstract class IMainScreenScopeDelegate implements ScopeDisposer {
  MainScreenWidgetModel getMainScreenWidgetModel();

  MainViewModel getMainViewModel();

  tg.ConnectionStateWidgetFactory getConnectionStateWidgetFactory();

  IStringsProvider getStringsProvider();

  HeaderViewModel getHeaderViewModel();

  tg.AvatarWidgetFactory getAvatarWidgetFactory();
}
