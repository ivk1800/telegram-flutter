import 'package:fake/fake.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:td_api/td_api.dart' as td;

class SettingsScreenShowcaseFactory {
  @j.inject
  SettingsScreenShowcaseFactory({
    required IStringsProvider stringsProvider,
  }) : _stringsProvider = stringsProvider;

  final IStringsProvider _stringsProvider;

  Widget create(BuildContext context) {
    final FakeTdFunctionExecutor fakeTdFunctionExecutor =
        FakeTdFunctionExecutor(
      resultFactory: (td.TdFunction object) {
        throw Exception('todo');
      },
    );

    final SettingsFeatureDependencies dependencies =
        SettingsFeatureDependencies(
      router: const _Router(),
      stringsProvider: _stringsProvider,
      userRepository: FakeUserRepository(
        fakeUserProvider: const FakeUserProvider(),
      ),
      optionsManager: FakeOptionsManager(
        functionExecutor: fakeTdFunctionExecutor,
      ),
      fileDownloader: const FakeFileDownloader(),
      settingsSearchScreenFactory: const FakeSettingsSearchScreenFactory(),
    );

    final SettingsFeature feature = SettingsFeature(
      dependencies: dependencies,
    );
    return feature.settingsScreenFactory.create();
  }
}

class _Router implements ISettingsScreenRouter {
  const _Router();

  @override
  void toChangeBio() {}

  @override
  void toChangeUsername() {}

  @override
  void toChatSettings() {}

  @override
  void toDataSettings() {}

  @override
  void toFolders() {}

  @override
  void toLogOut() {}

  @override
  void toNotificationsSettings() {}

  @override
  void toPrivacySettings() {}

  @override
  void toSessions() {}
}
