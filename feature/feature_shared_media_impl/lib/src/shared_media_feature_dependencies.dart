library feature_shared_media;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:dmg_annotation/dmg_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:localization_api/localization_api.dart';

@immutable
@dependencies
class SharedMediaFeatureDependencies {
  const SharedMediaFeatureDependencies({
    required this.messageRepository,
    required this.stringsProvider,
  });

  final IChatMessageRepository messageRepository;
  final IStringsProvider stringsProvider;
}
