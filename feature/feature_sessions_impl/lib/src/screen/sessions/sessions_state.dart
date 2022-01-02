import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tile/tile.dart';

part 'sessions_state.freezed.dart';

@freezed
@immutable
class SessionsState with _$SessionsState {
  const factory SessionsState({
    required ITileModel activeSession,
    required List<ITileModel> sessions,
  }) = _Data;

  const factory SessionsState.loading() = _Loading;
}
