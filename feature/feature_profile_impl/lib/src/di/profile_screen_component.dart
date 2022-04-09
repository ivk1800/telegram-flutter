import 'package:chat_info/chat_info.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_impl/feature_profile_impl.dart';
import 'package:feature_profile_impl/src/screen/profile/bloc/profile_bloc.dart';
import 'package:feature_profile_impl/src/screen/profile/bloc/profile_event.dart';
import 'package:feature_profile_impl/src/screen/profile/content_interactor.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_args.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(
  modules: <Type>[ProfileScreenModule],
)
abstract class IProfileScreenComponent {
  IChatHeaderInfoFactory getChatHeaderInfoFactory();

  ProfileBloc getProfileBloc();

  ILocalizationManager getLocalizationManager();
}

@j.module
abstract class ProfileScreenModule {
  @j.provides
  @j.singleton
  static IChatHeaderInfoFactory provideChatHeaderInfoFactory(
    ProfileArgs args,
    ProfileFeatureDependencies dependencies,
  ) =>
      dependencies.chatHeaderInfoFeatureApi.getChatHeaderInfoFactory();

  @j.provides
  @j.singleton
  static ProfileBloc provideProfileBloc(
    ProfileArgs args,
    ProfileFeatureDependencies dependencies,
    ContentInteractor contentInteractor,
    ChatInfoResolver chatInfoResolver,
  ) =>
      ProfileBloc(
        router: dependencies.router,
        args: args,
        chatInfoResolver: chatInfoResolver,
        headerInfoInteractor: dependencies.chatHeaderInfoFeatureApi
            .getChatHeaderInfoInteractor(args.id),
        contentInteractor: contentInteractor,
      )..add(const ProfileEvent.init());

  @j.provides
  @j.singleton
  static ChatInfoResolver provideChatInfoResolver(
    ProfileFeatureDependencies dependencies,
  ) =>
      ChatInfoResolver(
        basicGroupRepository: dependencies.basicGroupRepository,
        chatRepository: dependencies.chatRepository,
        superGroupRepository: dependencies.superGroupRepository,
      );

  @j.provides
  @j.singleton
  static ContentInteractor provideContentInteractor(
    ProfileArgs args,
    ProfileFeatureDependencies dependencies,
  ) =>
      ContentInteractor(
        args: args,
        localizationManager: dependencies.localizationManager,
        chatRepository: dependencies.chatRepository,
        userRepository: dependencies.userRepository,
        basicGroupRepository: dependencies.basicGroupRepository,
        superGroupRepository: dependencies.superGroupRepository,
        messageRepository: dependencies.messageRepository,
      );

  @j.provides
  @j.singleton
  static ILocalizationManager provideLocalizationManager(
    ProfileFeatureDependencies dependencies,
  ) =>
      dependencies.localizationManager;
}

@j.componentBuilder
abstract class IProfileScreenComponentBuilder {
  IProfileScreenComponentBuilder dependencies(
    ProfileFeatureDependencies dependencies,
  );

  IProfileScreenComponentBuilder chatArgs(ProfileArgs args);

  IProfileScreenComponent build();
}
