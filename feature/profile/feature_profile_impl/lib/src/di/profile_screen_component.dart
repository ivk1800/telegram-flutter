import 'package:chat_info/chat_info.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_impl/src/profile_feature_dependencies.dmg.dart';
import 'package:feature_profile_impl/src/screen/profile/content_interactor.dart';
import 'package:feature_profile_impl/src/screen/profile/header_actions_resolver.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_args.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:user_info/user_info.dart';

import 'profile_screen_component_builder.dart';

@j.Component(
  modules: <Type>[
    ProfileScreenModule,
    ProfileFeatureDependenciesModule,
  ],
  builder: IProfileScreenComponentBuilder,
)
@j.singleton
abstract class IProfileScreenComponent implements IProfileScreenScopeDelegate {}

@j.module
abstract class ProfileScreenModule {
  @j.provides
  @j.singleton
  static IChatHeaderInfoFactory provideChatHeaderInfoFactory(
    ProfileArgs args,
    IChatHeaderInfoFeatureApi chatHeaderInfoFeatureApi,
  ) =>
      chatHeaderInfoFeatureApi.getChatHeaderInfoFactory();

  @j.provides
  @j.singleton
  static IChatHeaderInfoInteractor provideChatHeaderInfoInteractor(
    ProfileArgs args,
    IChatHeaderInfoFeatureApi chatHeaderInfoFeatureApi,
  ) =>
      chatHeaderInfoFeatureApi.getChatHeaderInfoInteractor(args.id);

  @j.provides
  @j.singleton
  static ChatInfoResolver provideChatInfoResolver(
    IBasicGroupRepository basicGroupRepository,
    IChatRepository chatRepository,
    ISuperGroupRepository superGroupRepository,
  ) =>
      ChatInfoResolver(
        basicGroupRepository: basicGroupRepository,
        chatRepository: chatRepository,
        superGroupRepository: superGroupRepository,
      );

  @j.provides
  @j.singleton
  static UserInfoResolver provideUserInfoResolver(
    IUserRepository userRepository,
  ) =>
      UserInfoResolver(userRepository: userRepository);

  @j.provides
  @j.singleton
  static HeaderActionsResolver provideHeaderActionsResolver(
    ChatInfoResolver chatInfoResolver,
    IStringsProvider stringsProvider,
    UserInfoResolver userInfoResolver,
  ) =>
      HeaderActionsResolver(
        stringsProvider: stringsProvider,
        chatInfoResolver: chatInfoResolver,
        userInfoResolver: userInfoResolver,
      );

  @j.provides
  @j.singleton
  static ContentInteractor provideContentInteractor(
    ProfileArgs args,
    IStringsProvider stringsProvider,
    IChatRepository chatRepository,
    IUserRepository userRepository,
    IBasicGroupRepository basicGroupRepository,
    ISuperGroupRepository superGroupRepository,
    IChatMessageRepository messageRepository,
  ) =>
      ContentInteractor(
        args: args,
        stringsProvider: stringsProvider,
        chatRepository: chatRepository,
        userRepository: userRepository,
        basicGroupRepository: basicGroupRepository,
        superGroupRepository: superGroupRepository,
        messageRepository: messageRepository,
      );
}
