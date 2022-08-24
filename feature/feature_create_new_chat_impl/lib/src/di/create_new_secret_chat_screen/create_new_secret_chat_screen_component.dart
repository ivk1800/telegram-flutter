import 'package:feature_create_new_chat_impl/src/di/scope/screen_scope.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_secret_chat/new_secret_chat.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Subcomponent(
  modules: <Type>[CreateNewSecretChatScreenModule],
)
@screenScope
abstract class ICreateNewSecretChatScreenComponent {
  NewSecretChatViewModel getNewSecretChatViewModel();

  IStringsProvider getStringsProvider();
}

@j.module
abstract class CreateNewSecretChatScreenModule {}
