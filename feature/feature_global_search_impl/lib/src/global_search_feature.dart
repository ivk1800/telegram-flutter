library feature_chats_list_impl;

import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_screen_factory.dart';

import 'global_search_feature_dependencies.dart';

export 'global_search_feature_router.dart';

class GlobalSearchFeature implements IGlobalSearchFeatureApi {
  GlobalSearchFeature({
    required GlobalSearchFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final GlobalSearchFeatureDependencies _dependencies;

  @override
  late final IGlobalSearchScreenFactory globalSearchScreenFactory =
      GlobalSearchScreenFactory(dependencies: _dependencies);
}
