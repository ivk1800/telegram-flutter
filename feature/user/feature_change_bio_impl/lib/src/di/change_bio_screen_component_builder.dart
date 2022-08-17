import 'package:feature_change_bio_impl/src/change_bio_feature_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

import 'change_bio_screen_component.dart';

@j.componentBuilder
abstract class IChangeBioScreenComponentBuilder {
  IChangeBioScreenComponentBuilder dependencies(
    ChangeBioFeatureDependencies dependencies,
  );

  IChangeBioScreenComponent build();
}
