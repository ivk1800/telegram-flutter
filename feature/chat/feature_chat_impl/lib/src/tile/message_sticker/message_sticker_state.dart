import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_sticker_state.freezed.dart';

@freezed
@immutable
class MessageStickerState with _$MessageStickerState {
  const factory MessageStickerState.loading() = MessageStickerStateLoading;

  const factory MessageStickerState.loadedStatic(File file) =
      MessageStickerStateLoadedStatic;

  const factory MessageStickerState.loadedAnimated(File file) =
      MessageStickerStateLoadedAnimated;
}
