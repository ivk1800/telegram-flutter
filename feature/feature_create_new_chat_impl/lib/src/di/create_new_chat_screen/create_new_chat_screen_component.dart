import 'package:feature_create_new_chat_impl/feature_create_new_chat_impl.dart';
import 'package:feature_create_new_chat_impl/src/di/scope/screen_scope.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_chat/new_chat.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_chat/new_chat_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;

@j.Subcomponent(
  modules: <Type>[CreateNewChatScreenModule],
)
@screenScope
abstract class ICreateNewChatScreenComponent
    implements INewChatScreenScopeDelegate {}

@j.module
abstract class CreateNewChatScreenModule {
  @screenScope
  @j.binds
  INewChatScreenRouter bindINewChatScreenRouter(ICreateNewChatRouter impl);
}
