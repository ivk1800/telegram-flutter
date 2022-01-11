library feature_shared_media;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_shared_media_api/feature_shared_media_api.dart';
import 'package:localization_api/localization_api.dart';

import 'src/screen/factory/shared_media_screen_factory.dart';

class SharedMediaFeatureApi implements ISharedMediaFeatureApi {
  SharedMediaFeatureApi({required SharedMediaFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final SharedMediaFeatureDependencies _dependencies;
  late final SharedMediaScreenFactory _sharedMediaScreenFactory =
      SharedMediaScreenFactory(
    dependencies: _dependencies,
  );

  @override
  ISharedMediaScreenFactory get sharedMediaScreenFactory =>
      _sharedMediaScreenFactory;
}

class SharedMediaFeatureDependencies {
  SharedMediaFeatureDependencies({
    required this.messageRepository,
    required this.localizationManager,
  });

  final IChatMessageRepository messageRepository;
  final ILocalizationManager localizationManager;
}
