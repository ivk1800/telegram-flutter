import 'package:feature_contacts_impl/feature_contacts_impl.dart';
import 'package:feature_contacts_impl/src/screen/contacts/contacts_view_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(
  modules: <Type>[ContactsScreenModule],
)
abstract class IContactsScreenComponent {
  IStringsProvider getStringsProvider();

  ContactsViewModel getContactsViewModel();
}

@j.module
abstract class ContactsScreenModule {
  @j.provides
  @j.singleton
  static IStringsProvider provideStringsProvider(
    ContactsFeatureDependencies dependencies,
  ) =>
      dependencies.stringsProvider;

  @j.provides
  @j.singleton
  static ContactsViewModel provideContactsViewModel(
    ContactsFeatureDependencies dependencies,
  ) =>
      ContactsViewModel(router: dependencies.router)..init();
}

@j.componentBuilder
abstract class IContactsScreenComponentBuilder {
  IContactsScreenComponentBuilder dependencies(
    ContactsFeatureDependencies dependencies,
  );

  IContactsScreenComponent build();
}
