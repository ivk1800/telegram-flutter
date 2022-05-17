library feature_chats_list_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_screen_factory.dart';
import 'package:localization_api/localization_api.dart';

import 'src/global_search_feature_router.dart';

export 'src/global_search_feature_router.dart';

class GlobalSearchFeature implements IGlobalSearchFeatureApi {
  GlobalSearchFeature({
    required GlobalSearchFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  late final GlobalSearchScreenFactory _globalSearchScreenFactory =
      GlobalSearchScreenFactory(dependencies: _dependencies);

  final GlobalSearchFeatureDependencies _dependencies;

  @override
  IGlobalSearchScreenFactory get globalSearchScreenFactory =>
      _globalSearchScreenFactory;
}

class GlobalSearchFeatureDependencies {
  const GlobalSearchFeatureDependencies({
    required this.stringsProvider,
    required this.chatRepository,
    required this.chatMessageRepository,
    required this.router,
    required this.fileRepository,
  });

  final IStringsProvider stringsProvider;
  final IGlobalSearchFeatureRouter router;
  final IChatRepository chatRepository;
  final IChatMessageRepository chatMessageRepository;
  final IFileRepository fileRepository;
}
