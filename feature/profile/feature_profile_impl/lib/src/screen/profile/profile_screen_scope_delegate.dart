import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:localization_api/localization_api.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';

import 'profile_view_model.dart';

@scope
abstract class IProfileScreenScopeDelegate implements ScopeDisposer {
  ProfileViewModel getProfileViewModel();

  IStringsProvider getStringProvider();

  IChatHeaderInfoFactory getChatHeaderInfoFactory();
}
