import 'package:dialog_api/dialog_api.dart' as dialog_api;
import 'package:dialog_api_flutter/dialog_api_flutter.dart';
import 'package:fake/fake.dart';
import 'package:feature_auth_impl/feature_auth_impl.dart';
import 'package:feature_country_api/feature_country_api.dart';
import 'package:feature_country_impl/feature_country_impl.dart';
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:split_view/split_view.dart';

class AuthShowcaseFactory {
  @j.inject
  AuthShowcaseFactory({
    required IStringsProvider stringsProvider,
    required GlobalKey<NavigatorState> navigatorKey,
  })  : _stringsProvider = stringsProvider,
        _navigatorKey = navigatorKey;

  final IStringsProvider _stringsProvider;
  final GlobalKey<NavigatorState> _navigatorKey;

  Widget create(BuildContext context) {
    final CountryFeature countryFeature = CountryFeature(
      dependencies: CountryFeatureDependencies(
        stringsProvider: _stringsProvider,
      ),
    );
    final SplitViewState splitView = SplitView.of(context);
    final AuthFeature authFeature = AuthFeature(
      dependencies: AuthFeatureDependencies(
        errorTransformer: const FakeErrorTransformer(),
        authenticationStateUpdatesProvider:
            FakeAuthenticationStateUpdatesProvider(),
        connectionStateProvider: const FakeConnectionStateProvider(),
        authenticationManager: FakeAuthenticationManager(
          phoneNumberCallback: (String phone) async {
            if (phone != '71111111111') {
              await Future<void>.delayed(const Duration(milliseconds: 200));
              throw Exception('invalid phone');
            }
            return Future<void>.delayed(const Duration(milliseconds: 500));
          },
          authenticationCode: (String code) async {
            if (code != '11111') {
              await Future<void>.delayed(const Duration(milliseconds: 200));
              throw Exception('invalid code');
            }
            return Future<void>.delayed(const Duration(milliseconds: 1000))
                .then((_) {
              splitView.removeUntil(ContainerType.top, (_) => false);
              return null;
            });
          },
        ),
        router: _Router(
          chooseCountryScreenFactory: countryFeature.chooseCountryScreenFactory,
          splitView: splitView,
          dialogNavigatorKey: _navigatorKey,
        ),
        stringsProvider: _stringsProvider,
        countryRepository: countryFeature.countryRepository,
      ),
    );

    return authFeature.authScreenFactory.create();
  }
}

class _Router implements IAuthFeatureRouter {
  _Router({
    required IChooseCountryScreenFactory chooseCountryScreenFactory,
    required GlobalKey<NavigatorState> dialogNavigatorKey,
    required SplitViewState splitView,
  })  : _dialogRouterImpl = DialogRouterImpl(
          dialogNavigatorKey: dialogNavigatorKey,
        ),
        _chooseCountryScreenFactory = chooseCountryScreenFactory,
        _splitView = splitView;

  final SplitViewState _splitView;
  final IChooseCountryScreenFactory _chooseCountryScreenFactory;
  final DialogRouterImpl _dialogRouterImpl;

  @override
  void toChooseCountry(
    void Function(Country country) callback,
  ) {
    final Widget widget = _chooseCountryScreenFactory.create(callback);
    _splitView.add(
      key: UniqueKey(),
      builder: (_) => widget,
      container: ContainerType.top,
    );
  }

  @override
  void toDialog({
    String? title,
    required dialog_api.Body body,
    List<dialog_api.Action> actions = const <dialog_api.Action>[],
  }) =>
      _dialogRouterImpl.toDialog(
        body: body,
        title: title,
        actions: actions,
      );
}
