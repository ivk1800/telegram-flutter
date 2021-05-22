import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/src/feature/feature.dart';
import 'package:presentation/src/page/page.dart';
import 'package:split_view/split_view.dart';
import 'package:jugger/jugger.dart' as j;

import 'navigation.dart';

class MainScreenRouterImpl implements IMainScreenRouter {
  @j.inject
  MainScreenRouterImpl(
      FeatureFactory featureFactory,
      SplitNavigationInfoProvider splitNavigationInfoProvider,
      KeyGenerator keyGenerator,
      SplitNavigationRouter navigationRouter)
      : _navigationRouter = navigationRouter,
        _featureFactory = featureFactory,
        _splitNavigationInfoProvider = splitNavigationInfoProvider,
        _keyGenerator = keyGenerator;

  final SplitNavigationInfoProvider _splitNavigationInfoProvider;
  final KeyGenerator _keyGenerator;
  final SplitNavigationRouter _navigationRouter;
  final FeatureFactory _featureFactory;

  @override
  void toSettings() {
    _navigationRouter.push(
        key: UniqueKey(),
        builder: (BuildContext context) => _featureFactory
            .createSettingsFeatureApi()
            .screenWidgetFactory
            .create(),
        container: ContainerType.Top);
  }
}
