import 'package:feature_profile_impl/src/screen/profile/content_interactor.dart';

import 'profile_state.dart';

extension ProfileStateExt on ProfileState {
  ProfileState copy({
    HeaderState? headerState,
    BodyState? bodyState,
  }) {
    return ProfileState(
      headerState: headerState ?? this.headerState,
      bodyState: bodyState ?? this.bodyState,
    );
  }
}

extension DataBodyStateExt on DataBodyState {
  DataBodyState copy({
    ContentData? content,
  }) {
    return DataBodyState(
      content: content ?? this.content,
    );
  }
}
