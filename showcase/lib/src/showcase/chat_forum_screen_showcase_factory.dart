import 'package:feature_chat_forum_impl/feature_chat_forum_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

class ChatForumScreenShowcaseFactory {
  @j.inject
  ChatForumScreenShowcaseFactory({
    required IStringsProvider stringsProvider,
  }) : _stringsProvider = stringsProvider;

  final IStringsProvider _stringsProvider;

  Widget create(BuildContext context) {
    final ChatForumFeatureDependencies dependencies =
        ChatForumFeatureDependencies(
      router: const _Router(),
      stringsProvider: _stringsProvider,
    );

    final ChatForumFeature feature = ChatForumFeature(
      dependencies: dependencies,
    );
    return feature.chatForumScreenFactory.create(0);
  }
}

class _Router implements IChatForumRouter {
  const _Router();

  @override
  void toChat(int chatId) {}
}
