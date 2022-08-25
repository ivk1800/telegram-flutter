import 'package:feature_shared_media_api/feature_shared_media_api.dart';

import 'screen/factory/shared_media_screen_factory.dart';
import 'shared_media_feature_dependencies.dart';

class SharedMediaFeature implements ISharedMediaFeatureApi {
  SharedMediaFeature({required SharedMediaFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final SharedMediaFeatureDependencies _dependencies;

  @override
  late final ISharedMediaScreenFactory sharedMediaScreenFactory =
      SharedMediaScreenFactory(dependencies: _dependencies);
}
