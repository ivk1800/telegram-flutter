import 'package:core_ui_jugger/core_ui_jugger.dart';
import 'package:feature_contacts_impl/feature_contacts_impl.dart';
import 'package:feature_contacts_impl/src/contacts_feature_dependencies.dmg.dart';
import 'package:feature_contacts_impl/src/screen/contacts/contacts_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;

@j.Component(modules: <Type>[
  ContactsFeatureDependenciesModule,
  TgAppBarModule,
])
abstract class IContactsScreenComponent
    implements IContactsScreenScopeDelegate {}

@j.componentBuilder
abstract class IContactsScreenComponentBuilder {
  IContactsScreenComponentBuilder dependencies(
    ContactsFeatureDependencies dependencies,
  );

  IContactsScreenComponent build();
}
