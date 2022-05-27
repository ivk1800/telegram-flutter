library feature_chat_impl;

import 'package:feature_chat_api/feature_chat_api.dart';

import 'chat_feature_dependencies.dart';
import 'widget/factory/chat_screen_factory.dart';

class ChatFeature implements IChatFeatureApi {
  ChatFeature({
    required ChatFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChatFeatureDependencies _dependencies;
  late final IChatScreenFactory _chatScreenFactory =
      ChatScreenFactory(dependencies: _dependencies);
  @override
  IChatScreenFactory get chatScreenFactory => _chatScreenFactory;
}
