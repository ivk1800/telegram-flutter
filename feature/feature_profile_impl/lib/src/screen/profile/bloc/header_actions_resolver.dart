import 'package:chat_info/chat_info.dart';
import 'package:feature_profile_api/feature_profile_api.dart';
import 'package:localization_api/localization_api.dart';
import 'package:user_info/user_info.dart';

import 'header_action_data.dart';

class HeaderActionsResolver {
  HeaderActionsResolver({
    required ChatInfoResolver chatInfoResolver,
    required UserInfoResolver userInfoResolver,
    required IStringsProvider stringsProvider,
  })  : _chatInfoResolver = chatInfoResolver,
        _stringsProvider = stringsProvider,
        _userInfoResolver = userInfoResolver;

  final ChatInfoResolver _chatInfoResolver;
  final IStringsProvider _stringsProvider;
  final UserInfoResolver _userInfoResolver;

  Stream<List<HeaderActionData>> resolveActions({
    required int id,
    required ProfileType type,
  }) {
    switch (type) {
      case ProfileType.user:
        return _userInfoResolver.resolveAsStream(id).map(_resolveForUser);
      case ProfileType.chat:
        return _chatInfoResolver.resolveAsStream(id).map((ChatInfo info) {
          return <HeaderActionData>[
            if (info.isCreator || info.isAdmin)
              HeaderActionData(
                action: HeaderAction.edit,
                label: 'edit',
              )
          ];
        });
    }
  }

  List<HeaderActionData> _resolveForUser(UserInfo info) {
    return <HeaderActionData>[
      if (!info.isContact)
        HeaderActionData(
          action: HeaderAction.addToContacts,
          label: _stringsProvider.addToContacts,
        )
    ];
  }
}
