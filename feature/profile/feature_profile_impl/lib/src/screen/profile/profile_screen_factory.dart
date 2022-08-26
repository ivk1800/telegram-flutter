import 'package:feature_profile_api/feature_profile_api.dart';
import 'package:feature_profile_impl/feature_profile_impl.dart';
import 'package:feature_profile_impl/src/di/profile_screen_component.jugger.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_args.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'profile_screen_scope_delegate.scope.dart';

class ProfileScreenFactory implements IProfileScreenFactory {
  ProfileScreenFactory({required ProfileFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final ProfileFeatureDependencies _dependencies;

  @override
  Widget create(int id, ProfileType type) {
    return ProfileScreenScope(
      child: const ProfilePage(),
      create: () => JuggerProfileScreenComponentBuilder()
          .dependencies(_dependencies)
          .chatArgs(ProfileArgs(id: id, type: type))
          .build(),
    );
  }
}
