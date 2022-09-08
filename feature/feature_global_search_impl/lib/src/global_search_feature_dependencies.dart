library feature_chats_list_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:dmg_annotation/dmg_annotation.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:flutter/foundation.dart';
import 'package:localization_api/localization_api.dart';

import 'global_search_feature_router.dart';

@immutable
@dependencies
class GlobalSearchFeatureDependencies {
  const GlobalSearchFeatureDependencies({
    required this.stringsProvider,
    required this.chatRepository,
    required this.chatMessageRepository,
    required this.router,
    required this.fileDownloader,
  });

  final IStringsProvider stringsProvider;
  final IGlobalSearchFeatureRouter router;
  final IChatRepository chatRepository;
  final IChatMessageRepository chatMessageRepository;
  final IFileDownloader fileDownloader;
}
