import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tile/tile.dart';

part 'message_showcase_state.freezed.dart';

@freezed
@immutable
class MessageShowcaseState with _$MessageShowcaseState {
  const factory MessageShowcaseState({
    required List<ITileModel> items,
  }) = _Data;

  const factory MessageShowcaseState.loading() = _Loading;
}
