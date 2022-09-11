import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tile/tile.dart';

part 'stickers_set_state.freezed.dart';

@immutable
@freezed
class StickersSetState with _$StickersSetState {
  const factory StickersSetState.loading() = StickersSetStateLoading;

  const factory StickersSetState.data({
    required String setName,
    required List<ITileModel> models,
  }) = StickersSetStateData;
}
