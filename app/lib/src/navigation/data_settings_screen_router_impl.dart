import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_data_settings_impl/feature_data_settings_impl.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/feature/feature.dart';
import 'package:presentation/src/feature/folders/feature_folders.dart';
import 'package:presentation/src/page/page.dart';
import 'package:split_view/split_view.dart';

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
