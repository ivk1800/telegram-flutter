import 'package:feature_logout_api/feature_logout_api.dart';
import 'package:feature_logout_impl/feature_logout_impl.dart';
import 'package:feature_logout_impl/src/screen/logout/bloc/logout_bloc.dart';
import 'package:feature_logout_impl/src/screen/logout/logout_page.dart';
import 'package:flutter/widgets.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class LogoutScreenFactory implements ILogoutScreenFactory {
  LogoutScreenFactory({
    required LogoutFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final LogoutFeatureDependencies _dependencies;

  @override
  Widget create(BuildContext context) {
    return MultiProvider(
      providers: <Provider<dynamic>>[
        Provider<ILocalizationManager>(
          create: (BuildContext context) => _dependencies.localizationManager,
        ),
        Provider<tg.TgAppBarFactory>(
          create: (BuildContext context) =>
              tg.TgAppBarFactory.withConnectionStateProvider(
            _dependencies.connectionStateProvider,
          ),
        ),
      ],
      child: BlocProvider<LogoutBloc>(
        create: (BuildContext context) => LogoutBloc(
          localizationManager: _dependencies.localizationManager,
          authenticationManager: _dependencies.authenticationManager,
          router: _dependencies.router,
        ),
        child: const LogoutPage(),
      ),
    );
  }
}
