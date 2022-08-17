import 'package:core_ui_jugger/core_ui_jugger.dart';
import 'package:feature_contacts_impl/src/contacts_feature_dependencies.dmg.dart';
import 'package:feature_contacts_impl/src/screen/contacts/contacts_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;

import 'contacts_screen_component_builder.dart';

@j.Component(
  modules: <Type>[
    ContactsFeatureDependenciesModule,
    TgAppBarModule,
  ],
  builder: IContactsScreenComponentBuilder,
)
abstract class IContactsScreenComponent
    implements IContactsScreenScopeDelegate {}
