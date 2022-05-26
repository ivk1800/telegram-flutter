library feature_shared_media;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:localization_api/localization_api.dart';

class SharedMediaFeatureDependencies {
  SharedMediaFeatureDependencies({
    required this.messageRepository,
    required this.localizationManager,
  });

  final IChatMessageRepository messageRepository;
  final ILocalizationManager localizationManager;
}
