import 'package:feature_chat_forum_api/feature_chat_forum_api.dart';

import 'chat_forum_feature_dependencies.dart';
import 'screen/chat_forum_screen_factory.dart';

class ChatForumFeature implements IChatForumFeatureApi {
  ChatForumFeature({
    required ChatForumFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChatForumFeatureDependencies _dependencies;

  @override
  late final IChatForumScreenFactory chatForumScreenFactory =
      ChatForumScreenFactory(dependencies: _dependencies);
}
