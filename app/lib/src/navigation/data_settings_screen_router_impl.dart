import 'package:feature_data_settings_impl/feature_data_settings_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:app/src/feature/feature.dart';

import 'navigation.dart';

class DataSettingsScreenRouterImpl implements IDataSettingsScreenRouter {
  @j.inject
  DataSettingsScreenRouterImpl(
      FeatureFactory featureFactory, SplitNavigationRouter navigationRouter)
      : _navigationRouter = navigationRouter,
        _featureFactory = featureFactory;

  final FeatureFactory _featureFactory;
  final SplitNavigationRouter _navigationRouter;
}
