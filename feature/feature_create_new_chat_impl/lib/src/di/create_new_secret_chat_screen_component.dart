import 'package:feature_create_new_chat_impl/src/screen/new_secret_chat/new_secret_chat.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'create_new_chat_component.dart';

@j.Component(
  dependencies: <Type>[ICreateNewChatComponent],
  modules: <Type>[CreateNewSecretChatScreenModule],
)
abstract class CreateNewSecretChatScreenComponent {
  NewSecretChatViewModel getNewSecretChatViewModel();

  ILocalizationManager getLocalizationManager();
}

@j.module
abstract class CreateNewSecretChatScreenModule {
  @j.singleton
  @j.provides
  static NewSecretChatViewModel provideNewSecretChatViewModel() =>
      NewSecretChatViewModel()..init();
}

@j.componentBuilder
abstract class CreateNewSecretChatScreenComponentBuilder {
  CreateNewSecretChatScreenComponentBuilder createNewChatComponent(
    ICreateNewChatComponent component,
  );

  CreateNewSecretChatScreenComponent build();
}
