import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_models/shared_models.dart';

part 'header_state.freezed.dart';

@freezed
@immutable
class HeaderState with _$HeaderState {
  const factory HeaderState.loading() = Loading;

  const factory HeaderState.data({
    required Avatar avatar,
    required String name,
    required String phoneNumberFormatted,
    required bool isDarkTheme,
  }) = Data;
}
