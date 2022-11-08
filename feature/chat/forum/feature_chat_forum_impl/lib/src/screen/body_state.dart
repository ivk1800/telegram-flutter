import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tile/tile.dart';

part 'body_state.freezed.dart';

@immutable
@freezed
class BodyState with _$BodyState {
  const factory BodyState.loading() = ChatForumLoadingState;

  const factory BodyState.empty() = ChatForumEmptyState;

  const factory BodyState.content({
    required List<ITileModel> topics,
  }) = ChatForumContentState;
}
