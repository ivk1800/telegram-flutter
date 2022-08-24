import 'package:feature_create_new_chat_impl/src/di/scope/screen_scope.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_secret_chat/new_secret_chat_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;

@j.Subcomponent(
  modules: <Type>[CreateNewSecretChatScreenModule],
)
@screenScope
abstract class ICreateNewSecretChatScreenComponent
    implements INewSecretChatScreenScopeDelegate {}

@j.module
abstract class CreateNewSecretChatScreenModule {}
