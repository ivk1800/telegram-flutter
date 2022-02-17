import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_settings_event.freezed.dart';

@freezed
@immutable
class ChatSettingsEvent with _$ChatSettingsEvent {
  const factory ChatSettingsEvent.stickersAndMasksTap() = StickersAndMasksTap;
  const factory ChatSettingsEvent.wallpapersTap() = WallpapersTap;
}
