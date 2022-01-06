import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.freezed.dart';

@freezed
@immutable
class SearchState<R> with _$SearchState<R> {
  const factory SearchState.def() = _Default;
  const factory SearchState.empty() = _Empty;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.result(R result) = Result<R>;
}
