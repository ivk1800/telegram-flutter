import 'package:feature_shared_media_impl/feature_shared_media_impl.dart';
import 'package:feature_shared_media_impl/src/screen/factory/share_media_view_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(
  modules: <Type>[SharedMediaModule],
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

@j.componentBuilder
abstract class ISharedMediaComponentBuilder {
  ISharedMediaComponentBuilder dependencies(
    SharedMediaFeatureDependencies dependencies,
  );

  ISharedMediaComponent build();
}
