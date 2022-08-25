import 'package:feature_change_bio_api/feature_change_bio_api.dart';

import 'change_bio_feature_dependencies.dart';
import 'screen/change_bio/change_bio_screen_factory.dart';

class ChangeBioFeature implements IChangeBioFeatureApi {
  ChangeBioFeature({
    required ChangeBioFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChangeBioFeatureDependencies _dependencies;

  @override
  late final IChangeBioScreenFactory changeBioScreenFactory =
      ChangeBioScreenFactory(dependencies: _dependencies);
}
