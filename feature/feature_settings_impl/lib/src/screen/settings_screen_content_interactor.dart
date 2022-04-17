import 'dart:async';

import 'package:core/core.dart';
import 'package:feature_settings_impl/src/screen/content_state.dart';
import 'package:localization_api/localization_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_info/user_info.dart';

class SettingsScreenContentInteractor {
  SettingsScreenContentInteractor({
    required UserInfoResolver userInfoResolver,
    required OptionsManager optionsManager,
    required IStringsProvider stringsProvider,
  })  : _userInfoResolver = userInfoResolver,
        _stringsProvider = stringsProvider,
        _optionsManager = optionsManager;

  final UserInfoResolver _userInfoResolver;
  final OptionsManager _optionsManager;
  final IStringsProvider _stringsProvider;

  late final Stream<ContentState> _stateStream = _userInfoStream().map(
    (UserInfo info) {
      final String username;
      if (info.user.username.isEmpty) {
        username = _stringsProvider.usernameEmpty;
      } else {
        username = '@${info.user.username}';
      }

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
          // todo format
          phoneNumberFormatted: '+${info.user.phoneNumber}',
          username: username,
        ),
      );
    },
  ).share();

  Stream<ContentState> get stateStream => _stateStream;

  Stream<UserInfo> _userInfoStream() =>
      Stream<int>.fromFuture(_optionsManager.getMyId())
          .flatMap(_userInfoResolver.resolveAsStream);
}
