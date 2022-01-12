import 'package:freezed_annotation/freezed_annotation.dart';

import 'search_page_state.dart';

part 'global_search_state.freezed.dart';

@freezed
@immutable
class GlobalSearchState with _$GlobalSearchState {
  const factory GlobalSearchState({
    required PageState chatsPageState,
    required PageState mediaPageState,
    required PageState linksPageState,
    required PageState filesPageState,
    required PageState musicPageState,
    required PageState voicePageState,
  }) = _Data;
}
