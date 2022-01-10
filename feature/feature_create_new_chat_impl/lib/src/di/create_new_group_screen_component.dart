import 'package:feature_create_new_chat_impl/src/screen/new_group/new_group_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'create_new_chat_component.dart';

@j.Component(
  dependencies: <Type>[CreateNewChatComponent],
  modules: <Type>[CreateNewGroupScreenModule],
)
abstract class CreateNewGroupScreenComponent {
  NewGroupViewModel getNewGroupViewModel();

  ILocalizationManager getLocalizationManager();
}

@j.module
abstract class CreateNewGroupScreenModule {
  @j.singleton
  @j.provides
  static NewGroupViewModel provideNewGroupViewModel() =>
      NewGroupViewModel()..init();
}

@j.componentBuilder
abstract class CreateNewGroupScreenComponentBuilder {
  CreateNewGroupScreenComponentBuilder createNewChatComponent(
    CreateNewChatComponent component,
  );

  CreateNewGroupScreenComponent build();
}
