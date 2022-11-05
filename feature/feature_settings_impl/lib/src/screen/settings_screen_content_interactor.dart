import 'dart:async';

import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:core_arch/core_arch.dart';
import 'package:core_presentation/core_presentation.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_settings_impl/src/screen/content_state.dart';
import 'package:localization_api/localization_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_api/td_api.dart' as td;
import 'package:user_info/user_info.dart';

class SettingsScreenContentInteractor with SubscriptionMixin {
  SettingsScreenContentInteractor({
    required UserInfoResolver userInfoResolver,
    required OptionsManager optionsManager,
    required IStringsProvider stringsProvider,
  })  : _userInfoResolver = userInfoResolver,
        _stringsProvider = stringsProvider,
        _optionsManager = optionsManager {
    subscribe(_stateStream(), _stateSubject.add);
  }

  final UserInfoResolver _userInfoResolver;
  final OptionsManager _optionsManager;
  final IStringsProvider _stringsProvider;

  final BehaviorSubject<ContentState> _stateSubject =
      BehaviorSubject<ContentState>.seeded(const ContentState.loading());

  Stream<ContentState> get stateStream => _stateSubject;

  Stream<ContentState> _stateStream() => _userInfoStream().map(_mapUserInfo);

  ContentState _mapUserInfo(UserInfo info) {
    final String username;
    final td.Usernames? usernames = info.user.usernames;
    if (usernames == null) {
      username = _stringsProvider.usernameEmpty;
    } else {
      // TODO handle empty list
      username = '@${usernames.activeUsernames.firstOrNull}';
    }

    return ContentState.data(
      appBarState: AppBarState(
        name: <String>[info.user.firstName, info.user.lastName]
            .where((String s) => s.isNotEmpty)
            .join(' '),
        onlineStatus: info.statusHumanString,
        avatar: Avatar.simple(
          abbreviation: getAvatarAbbreviation(
            first: info.user.firstName,
            second: info.user.lastName,
          ),
          objectId: info.user.id,
          imageFileId: info.user.profilePhoto?.small.id,
        ),
      ),
      bodyState: BodyState(
        bio: '',
        // todo format
        phoneNumberFormatted: '+${info.user.phoneNumber}',
        username: username,
      ),
    );
  }

  Stream<UserInfo> _userInfoStream() =>
      Stream<int>.fromFuture(_optionsManager.getMyId())
          .flatMap(_userInfoResolver.resolveAsStream);

  @override
  void dispose() {
    _stateSubject.close();
    super.dispose();
  }
}
