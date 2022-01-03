import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tile/tile.dart';

part 'search_state.freezed.dart';

@freezed
@immutable
class SearchState with _$SearchState {
  const factory SearchState.loading() = _Loading;
  const factory SearchState.empty() = _Empty;

  const factory SearchState.data({
    required List<ITileModel> models,
  }) = _Data;
}
