import 'package:feature_shared_media_api/feature_shared_media_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'header_action_data.dart';
import 'profile_state.dart';

part 'profile_event.freezed.dart';

@freezed
@immutable
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.init() = Init;

  const factory ProfileEvent.notificationToggleTap() = NotificationToggleTap;

  const factory ProfileEvent.notificationTap() = NotificationTap;

  const factory ProfileEvent.headerActionTap(
    HeaderAction action,
  ) = HeaderActionTap;

  const factory ProfileEvent.messagesTap(SharedContentType type) = MessagesTap;

  // TODO: internal logic in state, refactor
  const factory ProfileEvent.newProfileState(ProfileState state) =
      NewProfileState;
}
