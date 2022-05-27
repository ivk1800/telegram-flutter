import 'package:chat_info/chat_info.dart';
import 'package:feature_chat_administration_impl/feature_chat_administration_impl.dart';
import 'package:feature_chat_administration_impl/src/screen/chat_administration/args.dart';
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
    ChatInfoResolver chatInfoResolver,
    Args args,
  ) =>
      ChatAdministrationViewModel(
        chatInfoResolver: chatInfoResolver,
        stringsProvider: dependencies.stringsProvider,
        chatId: args.chatId,
        errorTransformer: dependencies.errorTransformer,
        blockInteractionManager: dependencies.blockInteractionManager,
        router: dependencies.routerFactory.create(args.chatId),
        chatManager: dependencies.chatManager,
      );

  @j.provides
  @j.singleton
  static ChatInfoResolver provideChatInfoResolver(
    ChatAdministrationFeatureDependencies dependencies,
  ) =>
      ChatInfoResolver(
        basicGroupRepository: dependencies.basicGroupRepository,
        chatRepository: dependencies.chatRepository,
        superGroupRepository: dependencies.superGroupRepository,
      );
}

@j.componentBuilder
abstract class IChatAdministrationScreenComponentBuilder {
  IChatAdministrationScreenComponentBuilder dependencies(
    ChatAdministrationFeatureDependencies dependencies,
  );

  IChatAdministrationScreenComponentBuilder args(Args args);

  IChatAdministrationScreenComponent build();
}
