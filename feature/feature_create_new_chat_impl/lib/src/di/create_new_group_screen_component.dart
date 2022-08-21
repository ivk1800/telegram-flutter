import 'package:feature_create_new_chat_impl/src/screen/new_group/new_group.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'create_new_chat_component.dart';
import 'create_new_group_screen_component_builder.dart';

@j.Component(
  dependencies: <Type>[ICreateNewChatComponent],
  modules: <Type>[CreateNewGroupScreenModule],
  builder: CreateNewGroupScreenComponentBuilder,
)
@j.singleton
abstract class ICreateNewGroupScreenComponent {
  NewGroupViewModel getNewGroupViewModel();

  IStringsProvider getStringsProvider();
}

@j.module
abstract class CreateNewGroupScreenModule {
  @j.singleton
  @j.provides
  static NewGroupViewModel provideNewGroupViewModel() => NewGroupViewModel();
}
