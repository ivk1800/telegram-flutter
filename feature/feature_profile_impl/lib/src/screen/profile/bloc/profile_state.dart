import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_impl/src/screen/profile/content_interactor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'header_action_data.dart';

part 'profile_state.freezed.dart';

@freezed
@immutable
class ProfileState with _$ProfileState {
  const factory ProfileState({
    required HeaderState headerState,
    required BodyState bodyState,
  }) = Profile;
}

@freezed
@immutable
class HeaderState with _$HeaderState {
  const factory HeaderState.info(
    ChatHeaderInfo info,
    List<HeaderActionData> actions,
  ) = Info;
}

@freezed
@immutable
class BodyState with _$BodyState {
  const factory BodyState.loading() = Loading;

  const factory BodyState.data(ContentData content) = Data;
}
