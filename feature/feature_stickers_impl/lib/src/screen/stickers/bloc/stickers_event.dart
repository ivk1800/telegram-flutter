import 'package:freezed_annotation/freezed_annotation.dart';

part 'stickers_event.freezed.dart';

@immutable
@freezed
class StickersEvent with _$StickersEvent {
  const factory StickersEvent.trendingStickersTap() = TrendingStickersTap;
  const factory StickersEvent.archivedStickersTap() = ArchivedStickersTap;
  const factory StickersEvent.masksTap() = MasksTap;
  const factory StickersEvent.stickerSetTap(int setId) = StickerSetTap;
  const factory StickersEvent.init() = Init;
}
