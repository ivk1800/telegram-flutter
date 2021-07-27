import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_impl/feature_profile_impl.dart';
import 'package:feature_profile_impl/src/screen/profile/bloc/profile_bloc.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_args.dart';
import 'package:jugger/jugger.dart' as j;

@j.Component(modules: <Type>[ProfileScreenModule])
abstract class ProfileScreenComponent {
  IChatHeaderInfoFactory getChatHeaderInfoFactory();

  ProfileBloc getProfileBloc();
}

@j.module
abstract class ProfileScreenModule {
  @j.provide
  @j.singleton
  static IChatHeaderInfoInteractor provideChatHeaderInfoInteractor(
    ProfileArgs args,
    ProfileFeatureDependencies dependencies,
  ) =>
      dependencies.chatHeaderInfoFeatureApi
          .getChatHeaderInfoInteractor(args.id);

  @j.provide
  @j.singleton
  static IChatHeaderInfoFactory provideChatHeaderInfoFactory(
    ProfileArgs args,
    ProfileFeatureDependencies dependencies,
  ) =>
      dependencies.chatHeaderInfoFeatureApi.getChatHeaderInfoFactory();

  @j.provide
  @j.singleton
  static ProfileBloc provideProfileBloc(
    ProfileArgs args,
  ) =>
      ProfileBloc(
        args: args,
      );
}

@j.componentBuilder
abstract class ProfileScreenComponentBuilder {
  ProfileScreenComponentBuilder dependencies(
    ProfileFeatureDependencies dependencies,
  );

  ProfileScreenComponentBuilder chatArgs(ProfileArgs args);

  ProfileScreenComponent build();
}
