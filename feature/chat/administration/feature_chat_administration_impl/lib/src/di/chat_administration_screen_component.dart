import 'package:chat_info/chat_info.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_ui_jugger/core_ui_jugger.dart';
import 'package:feature_chat_administration_impl/feature_chat_administration_impl.dart';
import 'package:feature_chat_administration_impl/src/chat_administration_feature_dependencies.dmg.dart';
import 'package:feature_chat_administration_impl/src/screen/chat_administration/args.dart';
import 'package:feature_chat_administration_impl/src/screen/chat_administration/chat_administration_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;

import 'chat_administration_screen_component_builder.dart';

@j.Component(
  modules: <Type>[
    ChatAdministrationScreenModule,
    ChatAdministrationFeatureDependenciesModule,
    TgAppBarModule,
  ],
  builder: IChatAdministrationScreenComponentBuilder,
)
@j.singleton
abstract class IChatAdministrationScreenComponent
    implements IChatAdministrationScreenScopeDelegate {}

@j.module
abstract class ChatAdministrationScreenModule {
  @j.provides
  static IChatAdministrationRouter provideChatAdministrationRouter(
    IChatAdministrationRouterFactory routerFactory,
    Args args,
  ) =>
      routerFactory.create(args.chatId);

  @j.provides
  @j.singleton
  static ChatInfoResolver provideChatInfoResolver(
    IBasicGroupRepository basicGroupRepository,
    ISuperGroupRepository superGroupRepository,
    IChatRepository chatRepository,
  ) =>
      ChatInfoResolver(
        basicGroupRepository: basicGroupRepository,
        chatRepository: chatRepository,
        superGroupRepository: superGroupRepository,
      );
}
