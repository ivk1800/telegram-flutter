import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_state.freezed.dart';

@freezed
@immutable
class ContentState with _$ContentState {
  const factory ContentState.loading() = ContentStateLoading;

  const factory ContentState.data({
    required AppBarState appBarState,
    required BodyState bodyState,
  }) = ContentStateData;
}

class AppBarState {
  AppBarState({
    required this.photoFileId,
    required this.userId,
    required this.name,
    required this.onlineStatus,
  });

  final int? photoFileId;
  final int userId;
  final String name;
  final String onlineStatus;
}

class BodyState {
  BodyState({
    required this.phoneNumberFormatted,
    required this.username,
    required this.bio,
  });

  final String phoneNumberFormatted;
  final String username;
  final String bio;
}
