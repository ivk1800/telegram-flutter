import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:feature_settings_search_impl/feature_settings_search_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/feature/folders/feature_folders.dart';
import 'package:presentation/src/page/page.dart';
import 'package:split_view/split_view.dart';

import 'navigation.dart';

class SettingsSearchScreenRouterImpl implements ISettingsSearchScreenRouter {
  @j.inject
  SettingsSearchScreenRouterImpl(
      SplitNavigationInfoProvider splitNavigationInfoProvider,
      KeyGenerator keyGenerator,
      SplitNavigationRouter navigationRouter)
      : _navigationRouter = navigationRouter,
        _splitNavigationInfoProvider = splitNavigationInfoProvider,
        _keyGenerator = keyGenerator;

  final SplitNavigationInfoProvider _splitNavigationInfoProvider;
  final KeyGenerator _keyGenerator;
  final SplitNavigationRouter _navigationRouter;
}
