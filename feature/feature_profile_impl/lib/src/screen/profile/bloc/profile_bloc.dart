import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_args.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required ProfileArgs args})
      : _args = args,
        super(ProfileState(
          headerState: HeaderState(
              info: ChatHeaderInfo(
            photoId: 0,
            title: 'title',
            chatId: args.id,
            subtitle: 'subtitle',
          )),
          bodyState: const LoadingBodyState(),
        ));

  final ProfileArgs _args;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {}
}
