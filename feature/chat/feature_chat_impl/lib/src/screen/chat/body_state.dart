import 'package:freezed_annotation/freezed_annotation.dart';

import 'messages_bundle.dart';

part 'body_state.freezed.dart';

@freezed
@immutable
class BodyState with _$BodyState {
  const factory BodyState.loading() = _Loading;

  const factory BodyState.empty() = _Empty;

  const factory BodyState.data({
    required IMessagesBundle messageBundle,
  }) = BodyData;
}
