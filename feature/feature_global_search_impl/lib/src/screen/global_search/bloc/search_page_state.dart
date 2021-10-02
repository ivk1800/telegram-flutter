import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tile/tile.dart';

part 'search_page_state.freezed.dart';

@freezed
@immutable
class PageState with _$PageState {
  const factory PageState.loading() = _Loading;
  const factory PageState.empty() = _Empty;

  const factory PageState.data({
    required List<ITileModel> models,
  }) = _Data;
}
