import 'package:dialog_api/dialog_api.dart' as dialog_api;
import 'package:fake/fake.dart';
import 'package:feature_logout_impl/feature_logout_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

class LogoutShowcaseFactory {
  @j.inject
  LogoutShowcaseFactory({
    required IStringsProvider stringsProvider,
  }) : _stringsProvider = stringsProvider;

  final IStringsProvider _stringsProvider;

  Widget create(BuildContext context) {
    final LogoutFeatureDependencies dependencies = LogoutFeatureDependencies(
      router: const _Router(),
      stringsProvider: _stringsProvider,
      authenticationManager: const FakeAuthenticationManager(),
      connectionStateProvider: const FakeConnectionStateProvider(),
    );

    final LogoutFeature feature = LogoutFeature(
      dependencies: dependencies,
    );
    return feature.logoutScreenFactory.create();
  }
}

class _Router implements ILogoutFeatureRouter {
  const _Router();

  @override
  void toAddAccount() {}

  @override
  void toChangeNumber() {}

  @override
  void toChat(int chatId) {}

  @override
  void toDialog({
    String? title,
    required dialog_api.Body body,
    List<dialog_api.Action> actions = const <dialog_api.Action>[],
  }) {}

  @override
  void toPasscodeSettings() {}

  @override
  void toStorageUsageSettings() {}
}
