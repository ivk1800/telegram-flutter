import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:feature_auth_impl/feature_auth_impl.dart';
import 'package:feature_auth_impl/src/di/di.dart';
import 'package:feature_auth_impl/src/screen/auth/auth_page.dart';
import 'package:feature_auth_impl/src/screen/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class AuthScreenFactory implements IAuthScreenFactory {
  AuthScreenFactory({required AuthFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final AuthFeatureDependencies _dependencies;

  @override
  Widget create() {
    return Provider<IAuthScreenComponent>(
      create: (_) => JuggerAuthScreenComponentBuilder()
          .dependencies(_dependencies)
          .build(),
      child: MultiProvider(
        providers: <Provider<dynamic>>[
          Provider<ILocalizationManager>(
            create: (BuildContext context) =>
                context.getComponent().getLocalizationManager(),
          ),
        ],
        child: BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              context.getComponent().getProfileBloc(),
          child: const AuthPage(),
        ),
      ),
    );
  }
}

extension _ContextExt on BuildContext {
  IAuthScreenComponent getComponent() => read<IAuthScreenComponent>();
}
