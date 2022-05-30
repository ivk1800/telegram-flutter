import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_models/shared_models.dart';

part 'avatar_state.freezed.dart';

@immutable
@freezed
class AvatarState with _$AvatarState {
  const factory AvatarState.thumbnail({
    required Minithumbnail thumbnail,
  }) = ThumbnailAvatarState;

  const factory AvatarState.abbreviation({
    required String abbreviation,
    required int objectId,
  }) = AbbreviationAvatarState;

  const factory AvatarState.file({required File file}) = FileAvatarState;
}
