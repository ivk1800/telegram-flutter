import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tile/tile.dart';

part 'body_state.freezed.dart';

@freezed
@immutable
class BodyState with _$BodyState {
  const factory BodyState.loading() = _Loading;

  const factory BodyState.data({
    required List<ITileModel> models,
  }) = BodyData;
}
