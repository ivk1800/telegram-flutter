import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tile/tile.dart';

part 'stickers_state.freezed.dart';

// TODO add loading state
@immutable
@freezed
class StickersState with _$StickersState {
  const factory StickersState.data(final List<ITileModel> tiles) = Data;
}
