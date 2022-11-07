import 'package:dmg_annotation/dmg_annotation.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'chat_forum_router.dart';

@dependencies
@immutable
class ChatForumFeatureDependencies {
  const ChatForumFeatureDependencies({
    required this.stringsProvider,
    required this.router,
  });

  final IStringsProvider stringsProvider;
  final IChatForumRouter router;
}
