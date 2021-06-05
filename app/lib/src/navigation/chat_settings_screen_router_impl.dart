import 'package:feature_chat_settings_impl/feature_chat_settings_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/feature/feature.dart';
import 'package:split_view/split_view.dart';

import 'navigation.dart';

class ChatSettingsScreenRouterImpl implements IChatSettingsScreenRouter {
  @j.inject
  ChatSettingsScreenRouterImpl(
      FeatureFactory featureFactory, SplitNavigationRouter navigationRouter)
      : _navigationRouter = navigationRouter,
        _featureFactory = featureFactory;

  final FeatureFactory _featureFactory;
  final SplitNavigationRouter _navigationRouter;

  @override
  void toStickersAndMasks() {
    _navigationRouter.push(
        key: UniqueKey(),
        builder: (BuildContext context) => _featureFactory
            .createStickersFeatureApi()
            .stickersWidgetFactory
            .create(),
        container: ContainerType.Top);
  }
}
