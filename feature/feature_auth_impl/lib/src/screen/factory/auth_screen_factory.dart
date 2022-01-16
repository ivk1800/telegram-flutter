import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:feature_auth_impl/feature_auth_impl.dart';
import 'package:feature_auth_impl/src/di/di.dart';
import 'package:feature_auth_impl/src/screen/auth/auth_page.dart';
import 'package:feature_auth_impl/src/screen/auth/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:provider_extensions/provider_extensions.dart';

class AuthScreenFactory implements IAuthScreenFactory {
  AuthScreenFactory({required AuthFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final AuthFeatureDependencies _dependencies;

  @override
  Widget create() {
    return Scope<IAuthScreenComponent>(
      create: () => JuggerAuthScreenComponentBuilder()
          .dependencies(_dependencies)
          .build(),
      providers: (IAuthScreenComponent component) {
        return <Provider<dynamic>>[
          ViewModelProvider<AuthViewModel>(
            create: (_) => component.getAuthViewModel(),
          ),
          Provider<ILocalizationManager>(
            create: (_) => component.getLocalizationManager(),
          ),
        ];
      },
      child: const AuthPage(),
    );
  }
}
