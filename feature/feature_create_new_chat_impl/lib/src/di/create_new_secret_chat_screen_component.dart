import 'package:feature_create_new_chat_impl/src/screen/new_secret_chat/new_secret_chat.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'create_new_chat_component.dart';
import 'create_new_secret_chat_screen_component_builder.dart';

@j.Component(
  dependencies: <Type>[ICreateNewChatComponent],
  modules: <Type>[CreateNewSecretChatScreenModule],
  builder: CreateNewSecretChatScreenComponentBuilder,
)
@j.singleton
abstract class ICreateNewSecretChatScreenComponent {
  NewSecretChatViewModel getNewSecretChatViewModel();

  IStringsProvider getStringsProvider();
}

@j.module
abstract class CreateNewSecretChatScreenModule {
  @j.singleton
  @j.provides
  static NewSecretChatViewModel provideNewSecretChatViewModel() =>
      NewSecretChatViewModel();
}
