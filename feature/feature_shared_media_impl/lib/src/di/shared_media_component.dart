import 'package:feature_shared_media_impl/feature_shared_media_impl.dart';
import 'package:feature_shared_media_impl/src/screen/factory/share_media_view_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'shared_media_component_builder.dart';

@j.Component(
  modules: <Type>[SharedMediaModule],
  builder: ISharedMediaComponentBuilder,
)
abstract class ISharedMediaComponent {
  ILocalizationManager getLocalizationManager();

  SharedMediaViewModel getSharedMediaViewModel();
}

@j.module
abstract class SharedMediaModule {
  @j.provides
  static ILocalizationManager provideLocalizationManager(
    SharedMediaFeatureDependencies dependencies,
  ) =>
      dependencies.localizationManager;

  @j.provides
  static SharedMediaViewModel provideSharedMediaViewModel(
    SharedMediaFeatureDependencies dependencies,
  ) =>
      SharedMediaViewModel();
}
