import 'package:feature_create_new_chat_impl/feature_create_new_chat_impl.dart';
import 'package:feature_create_new_chat_impl/src/di/scope/screen_scope.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_chat/new_chat.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Subcomponent(
  modules: <Type>[CreateNewChatScreenModule],
)
@screenScope
abstract class ICreateNewChatScreenComponent {
  NewChatViewModel getNewChatViewModel();

  IStringsProvider getStringsProvider();
}

@j.module
abstract class CreateNewChatScreenModule {
  @screenScope
  @j.binds
  INewChatScreenRouter bindINewChatScreenRouter(ICreateNewChatRouter impl);
}
