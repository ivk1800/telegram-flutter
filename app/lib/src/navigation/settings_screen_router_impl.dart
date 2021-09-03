import 'package:app/src/feature/feature.dart';
import 'package:app/src/feature/folders/feature_folders.dart';
import 'package:app/src/page/page.dart';
import 'package:feature_logout_api/feature_logout_api.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:split_view/split_view.dart';

import 'navigation.dart';

class SettingsScreenRouterImpl implements ISettingsScreenRouter {
  @j.inject
  SettingsScreenRouterImpl(
    FeatureFactory featureFactory,
    SplitNavigationRouter navigationRouter,
  )   : _navigationRouter = navigationRouter,
        _featureFactory = featureFactory;

  final FeatureFactory _featureFactory;
  final SplitNavigationRouter _navigationRouter;

  @override
  void toFolders() {
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => const FoldersSetupPage().wrap(),
      container: ContainerType.Top,
    );
  }

  @override
  void toSessions() {
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => const SessionsPage(),
      container: ContainerType.Top,
    );
  }

  @override
  void toPrivacySettings() {
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => _featureFactory
          .createPrivacySettingsFeatureApi()
          .screenWidgetFactory
          .create(),
      container: ContainerType.Top,
    );
  }

  @override
  void toNotificationsSettings() {
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => _featureFactory
          .createNotificationsSettingsFeatureApi()
          .screenWidgetFactory
          .create(),
      container: ContainerType.Top,
    );
  }

  @override
  void toDataSettings() {
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => _featureFactory
          .createDataSettingsFeatureApi()
          .screenWidgetFactory
          .create(),
      container: ContainerType.Top,
    );
  }

  @override
  void toChatSettings() {
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => _featureFactory
          .createChatSettingsFeatureApi()
          .screenWidgetFactory
          .create(),
      container: ContainerType.Top,
    );
  }

  @override
  void toLogOut() {
    final ILogoutScreenFactory factory =
        _featureFactory.createLogoutFeatureApi().logoutScreenFactory;
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) {
        return factory.create(context);
      },
      container: ContainerType.Top,
    );
  }
}
