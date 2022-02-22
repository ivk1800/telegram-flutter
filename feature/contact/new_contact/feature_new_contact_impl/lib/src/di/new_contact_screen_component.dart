import 'package:feature_new_contact_impl/feature_new_contact_impl.dart';
import 'package:feature_new_contact_impl/src/screen/new_contact/new_contact_view_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(
  modules: <Type>[NewContactScreenModule],
)
abstract class INewContactScreenComponent {
  IStringsProvider getStringsProvider();

  NewContactViewModel getNewContactViewModel();
}

@j.module
abstract class NewContactScreenModule {
  @j.provides
  @j.singleton
  static IStringsProvider provideStringsProvider(
    NewContactFeatureDependencies dependencies,
  ) =>
      dependencies.stringsProvider;

  @j.provides
  @j.singleton
  static INewContactRouter provideNewContactRouter(
    NewContactFeatureDependencies dependencies,
  ) =>
      dependencies.router;
}

@j.componentBuilder
abstract class INewContactScreenComponentBuilder {
  INewContactScreenComponentBuilder dependencies(
    NewContactFeatureDependencies dependencies,
  );

  INewContactScreenComponent build();
}
