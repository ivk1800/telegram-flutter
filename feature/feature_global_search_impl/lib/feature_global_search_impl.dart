library feature_chats_list_impl;

import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'src/widget/factory/global_search_widget_factory.dart';

class GlobalSearchFeatureApi implements IGlobalSearchFeatureApi {
  GlobalSearchFeatureApi({required this.dependencies})
      : _screenWidgetFactory =
            GlobalSearchWidgetFactory(dependencies: dependencies);

  final IGlobalSearchWidgetFactory _screenWidgetFactory;

  final IGlobalSearchFeatureDependencies dependencies;

  @override
  IGlobalSearchWidgetFactory get screenWidgetFactory => _screenWidgetFactory;
}

abstract class IGlobalSearchFeatureDependencies {}
