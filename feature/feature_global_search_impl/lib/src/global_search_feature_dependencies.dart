library feature_chats_list_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:localization_api/localization_api.dart';

import 'global_search_feature_router.dart';

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
