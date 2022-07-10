import 'package:feature_change_username_api/feature_change_username_api.dart';
import 'package:feature_change_username_impl/feature_change_username_impl.dart';
import 'package:feature_change_username_impl/src/di/change_username_screen_component.jugger.dart';
import 'package:flutter/material.dart';

import 'change_username_page.dart';
import 'change_username_screen_scope_delegate.scope.dart';

class ChangeUsernameScreenFactory implements IChangeUsernameScreenFactory {
  ChangeUsernameScreenFactory({
    required ChangeUsernameFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChangeUsernameFeatureDependencies _dependencies;

  @override
  Widget create() {
    return ChangeUsernameScreenScope(
      child: const ChangeUsernamePage(),
      create: () => JuggerChangeUsernameScreenComponentBuilder()
          .dependencies(_dependencies)
          .build(),
    );
  }
}
