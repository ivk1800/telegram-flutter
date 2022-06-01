import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:feature_auth_impl/feature_auth_impl.dart';
import 'package:feature_auth_impl/src/di/auth_screen_component.jugger.dart';
import 'package:feature_auth_impl/src/screen/auth/auth_page.dart';
import 'package:feature_auth_impl/src/screen/auth/auth_screen_scope.dart';
import 'package:flutter/material.dart';

class AuthScreenFactory implements IAuthScreenFactory {
  AuthScreenFactory({required AuthFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final AuthFeatureDependencies _dependencies;

  @override
  Widget create() {
    return AuthScreenScope(
      child: const AuthPage(),
      create: () => JuggerAuthScreenComponentBuilder()
          .dependencies(_dependencies)
          .build(),
    );
  }
}
