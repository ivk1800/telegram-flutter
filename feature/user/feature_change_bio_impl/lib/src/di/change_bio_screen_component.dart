import 'package:feature_change_bio_impl/feature_change_bio_impl.dart';
import 'package:feature_change_bio_impl/src/screen/change_bio/change_bio_view_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(
  modules: <Type>[ChangeBioScreenModule],
)
abstract class IChangeBioScreenComponent {
  IStringsProvider getStringsProvider();

  ChangeBioViewModel getChangeBioViewModel();
}

@j.module
abstract class ChangeBioScreenModule {
  @j.provides
  @j.singleton
  static IStringsProvider provideStringsProvider(
    ChangeBioFeatureDependencies dependencies,
  ) =>
      dependencies.stringsProvider;

  @j.provides
  @j.singleton
  static ChangeBioViewModel provideChangeBioViewModel(
    ChangeBioFeatureDependencies dependencies,
  ) =>
      ChangeBioViewModel();
}

@j.componentBuilder
abstract class IChangeBioScreenComponentBuilder {
  IChangeBioScreenComponentBuilder dependencies(
    ChangeBioFeatureDependencies dependencies,
  );

  IChangeBioScreenComponent build();
}
