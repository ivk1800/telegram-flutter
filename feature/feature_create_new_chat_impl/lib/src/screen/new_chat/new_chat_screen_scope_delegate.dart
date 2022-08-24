import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:localization_api/localization_api.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';

import 'new_chat.dart';

@scope
abstract class INewChatScreenScopeDelegate implements ScopeDisposer {
  NewChatViewModel getNewChatViewModel();

  IStringsProvider getStringsProvider();
}
