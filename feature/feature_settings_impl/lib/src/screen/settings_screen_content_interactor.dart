import 'dart:async';

import 'package:core/core.dart';
import 'package:feature_settings_impl/src/screen/content_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_info/user_info.dart';

class SettingsScreenContentInteractor {
  SettingsScreenContentInteractor({
    required UserInfoResolver userInfoResolver,
    required OptionsManager optionsManager,
  })  : _userInfoResolver = userInfoResolver,
        _optionsManager = optionsManager;

  final UserInfoResolver _userInfoResolver;
  final OptionsManager _optionsManager;

  late final Stream<ContentState> _stateStream = _userInfoStream().map(
    (UserInfo info) {
      return ContentState.data(
        appBarState: AppBarState(
          name: <String>[info.user.firstName, info.user.lastName]
              .where((String s) => s.isNotEmpty)
              .join(' '),
          onlineStatus: info.statusHumanString,
          userId: info.user.id,
          photoFileId: info.user.profilePhoto?.small.id,
        ),
        bodyState: BodyState(
          bio: '',
          phoneNumberFormatted: info.user.phoneNumber,
          username: info.user.username,
        ),
      );
    },
  ).share();

  Stream<ContentState> get stateStream => _stateStream;

  Stream<UserInfo> _userInfoStream() =>
      Stream<int>.fromFuture(_optionsManager.getMyId())
          .flatMap(_userInfoResolver.resolveAsStream);
}
