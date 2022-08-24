import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';

import 'new_secret_chat.dart';

@scope
abstract class INewSecretChatScreenScopeDelegate implements ScopeDisposer {
  NewSecretChatViewModel getNewSecretChatViewModel();
}
