import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_username_state.freezed.dart';

@freezed
@immutable
class CheckUsernameState with _$CheckUsernameState {
  const factory CheckUsernameState.loading() = CheckUsernameStateLoading;

  const factory CheckUsernameState.data({
    required String initialUsername,
  }) = CheckUsernameStateData;
}
