import 'package:chat_info/chat_info.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_profile_api/feature_profile_api.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tdlib/td_api.dart' as td;

import 'header_action_data.dart';

class HeaderActionsResolver {
  HeaderActionsResolver({
    required ChatInfoResolver chatInfoResolver,
    required IUserRepository userRepository,
    required IStringsProvider stringsProvider,
  })  : _chatInfoResolver = chatInfoResolver,
        _stringsProvider = stringsProvider,
        _userRepository = userRepository;

  final ChatInfoResolver _chatInfoResolver;
  final IStringsProvider _stringsProvider;
  final IUserRepository _userRepository;

  Stream<List<HeaderActionData>> resolveActions({
    required int id,
    required ProfileType type,
  }) {
    switch (type) {
      case ProfileType.user:
        return Stream<td.User>.fromFuture(_userRepository.getUser(id))
            .map(_resolveForUser);
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

  List<HeaderActionData> _resolveForUser(td.User user) {
    return <HeaderActionData>[
      if (!user.isContact)
        HeaderActionData(
          action: HeaderAction.addToContacts,
          label: _stringsProvider.addToContacts,
        )
    ];
  }
}
