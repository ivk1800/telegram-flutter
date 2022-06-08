import 'package:freezed_annotation/freezed_annotation.dart';

part 'empty_state.freezed.dart';

@freezed
@immutable
class EmptyState with _$EmptyState {
  const factory EmptyState.self() = Self;
  const factory EmptyState.common() = Commmon;
}
