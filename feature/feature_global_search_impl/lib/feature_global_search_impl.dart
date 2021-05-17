library feature_chats_list_impl;

import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:flutter/widgets.dart';
import 'src/di/global_search_screen_component.dart';

import 'src/screen/global_search_page.dart';

class GlobalSearchFeatureApi implements IGlobalSearchFeatureApi {
  GlobalSearchFeatureApi({required this.dependencies})
      : _screenWidgetFactory = _ScreenWidgetFactory(dependencies: dependencies);

  final IGlobalSearchWidgetFactory _screenWidgetFactory;

  final IGlobalSearchFeatureDependencies dependencies;

  @override
  IGlobalSearchWidgetFactory get screenWidgetFactory => _screenWidgetFactory;
}

abstract class IGlobalSearchFeatureDependencies {}

class _ScreenWidgetFactory implements IGlobalSearchWidgetFactory {
  _ScreenWidgetFactory({required this.dependencies});

  final IGlobalSearchFeatureDependencies dependencies;

  @override
  Widget create() => const GlobalSearchPage().wrap(dependencies);
}
