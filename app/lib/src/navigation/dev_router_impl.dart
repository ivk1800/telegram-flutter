import 'package:feature_dev/feature_dev.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/feature/feature.dart';
import 'package:split_view/split_view.dart';

import 'navigation.dart';

class DevScreenRouterImpl implements IDevFeatureRouter {
  @j.inject
  DevScreenRouterImpl(
      SplitNavigationRouter navigationRouter, FeatureFactory featureFactory)
      : _navigationRouter = navigationRouter,
        _featureFactory = featureFactory;

  final SplitNavigationRouter _navigationRouter;
  final FeatureFactory _featureFactory;

  @override
  void toEventsList() {
    _navigationRouter.push(
        key: UniqueKey(),
        builder: (BuildContext context) =>
            _featureFactory.createDevFeature().createEventsListWidget(),
        container: ContainerType.Top);
  }
}
