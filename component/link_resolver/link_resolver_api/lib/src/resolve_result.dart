import 'package:freezed_annotation/freezed_annotation.dart';

part 'resolve_result.freezed.dart';

@freezed
@immutable
class ResolveResult with _$ResolveResult {
  const factory ResolveResult.username(String value) = Username;
  const factory ResolveResult.nothing() = Nothing;
}
