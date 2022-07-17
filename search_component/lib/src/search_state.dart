import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.freezed.dart';

@freezed
@immutable
class SearchState<R> with _$SearchState<R> {
  const factory SearchState.def() = _Default<R>;
  const factory SearchState.empty() = _Empty<R>;
  const factory SearchState.loading() = _Loading<R>;
  const factory SearchState.result(R result) = Result<R>;
}
