import 'package:feature_chat_administration_impl/feature_chat_administration_impl.dart';
import 'package:feature_chat_administration_impl/src/screen/chat_administration/chat_administration_router.dart';
import 'package:feature_chat_administration_impl/src/screen/chat_administration/chat_administration_view_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(
  modules: <Type>[ChatAdministrationScreenModule],
)
abstract class IChatAdministrationScreenComponent {
  IStringsProvider getStringsProvider();

  ChatAdministrationViewModel getChatAdministrationViewModel();
}

@j.module
abstract class ChatAdministrationScreenModule {
  @j.provides
  @j.singleton
  static IStringsProvider provideStringsProvider(
    ChatAdministrationFeatureDependencies dependencies,
  ) =>
      dependencies.stringsProvider;

  @j.provides
  @j.singleton
  static ChatAdministrationViewModel provideChatAdministrationViewModel(
    ChatAdministrationFeatureDependencies dependencies,
  ) =>
      ChatAdministrationViewModel();
}

@j.componentBuilder
abstract class IChatAdministrationScreenComponentBuilder {
  IChatAdministrationScreenComponentBuilder dependencies(
    ChatAdministrationFeatureDependencies dependencies,
  );

  IChatAdministrationScreenComponent build();
}
