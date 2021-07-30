import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_api/feature_profile_api.dart';
import 'package:feature_profile_impl/feature_profile_impl.dart';
import 'package:feature_profile_impl/src/di/di.dart';
import 'package:feature_profile_impl/src/screen/profile/bloc/profile_bloc.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_args.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class ProfileScreenFactory implements IProfileScreenFactory {
  ProfileScreenFactory({required ProfileFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final ProfileFeatureDependencies _dependencies;

  @override
  Widget create(BuildContext context, int id) =>
      Provider<ProfileScreenComponent>(
        create: (_) => JuggerProfileScreenComponentBuilder()
            .dependencies(_dependencies)
            .chatArgs(ProfileArgs(id))
            .build(),
        child: MultiProvider(
            providers: <Provider<dynamic>>[
              Provider<IChatHeaderInfoFactory>(
                create: (BuildContext context) =>
                    context.getComponent().getChatHeaderInfoFactory(),
              ),
              Provider<ILocalizationManager>(
                create: (BuildContext context) =>
                    context.getComponent().getLocalizationManager(),
              ),
            ],
            child: BlocProvider<ProfileBloc>(
                create: (BuildContext context) =>
                    context.getComponent().getProfileBloc(),
                child: const ProfilePage())),
      );
}

extension _ContextExt on BuildContext {
  ProfileScreenComponent getComponent() =>
      Provider.of<ProfileScreenComponent>(this, listen: false);
}
