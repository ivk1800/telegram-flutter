library feature_shared_media;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_shared_media_api/feature_shared_media_api.dart';

import 'src/screen/factory/shared_media_screen_factory.dart';

class SharedMediaFeatureApi implements ISharedMediaFeatureApi {
  SharedMediaFeatureApi({required SharedMediaFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final SharedMediaFeatureDependencies _dependencies;
  SharedMediaScreenFactory? _sharedMediaScreenFactory;

  @override
  ISharedMediaScreenFactory get sharedMediaScreenFactory =>
      _sharedMediaScreenFactory ??= SharedMediaScreenFactory(
        dependencies: _dependencies,
      );
}

class SharedMediaFeatureDependencies {
  SharedMediaFeatureDependencies({
    required this.messageRepository,
  });

  final IChatMessageRepository messageRepository;
}
