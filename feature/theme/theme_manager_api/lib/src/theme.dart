import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme.freezed.dart';

@immutable
@freezed
class Theme with _$Theme {
  const factory Theme.classic() = Classic;
  const factory Theme.dark() = Dark;
}
