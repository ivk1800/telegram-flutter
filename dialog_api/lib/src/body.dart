import 'package:freezed_annotation/freezed_annotation.dart';

part 'body.freezed.dart';

@freezed
@immutable
class Body with _$Body {
  const factory Body.text({
    required String text,
  }) = _Text;
}
