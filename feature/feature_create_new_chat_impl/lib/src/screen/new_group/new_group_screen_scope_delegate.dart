import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';

import 'new_group.dart';

@scope
abstract class INewGroupScreenScopeDelegate implements ScopeDisposer {
  NewGroupViewModel getNewGroupViewModel();
}
