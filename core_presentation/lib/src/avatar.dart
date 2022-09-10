import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_models/shared_models.dart';

part 'avatar.freezed.dart';

@immutable
@freezed
class Avatar with _$Avatar {
  const factory Avatar.simple({
    required int objectId,
    required String abbreviation,
    required int? imageFileId,
    Minithumbnail? minithumbnail,
  }) = SimpleAvatar;

  const factory Avatar.savedMessages() = SavedMessagesAvatar;
}
