import 'package:freezed_annotation/freezed_annotation.dart';

import 'new_contact_view_model.dart';

part 'new_contact_state.freezed.dart';

@freezed
@immutable
class NewContactState with _$NewContactState {
  const factory NewContactState.loading() = LoadingState;
  const factory NewContactState.data({
    required UserInformation userInformation,
  }) = DataState;
}
