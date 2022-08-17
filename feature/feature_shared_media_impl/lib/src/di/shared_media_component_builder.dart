import 'package:feature_shared_media_impl/src/di/shared_media_component.dart';
import 'package:feature_shared_media_impl/src/shared_media_feature_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

@j.componentBuilder
abstract class ISharedMediaComponentBuilder {
  ISharedMediaComponentBuilder dependencies(
    SharedMediaFeatureDependencies dependencies,
  );

  ISharedMediaComponent build();
}
