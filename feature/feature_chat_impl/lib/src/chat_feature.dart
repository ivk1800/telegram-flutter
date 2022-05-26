library feature_chat_impl;

import 'package:feature_chat_api/feature_chat_api.dart';

import 'chat_feature_dependencies.dart';
import 'widget/factory/chat_screen_factory.dart';

export 'package:profile_navigation_api/profile_navigation_api.dart';

export 'chat_screen_router.dart';
export 'chat_screen_router_factory.dart';
export 'component/message_mapper_component.dart';
export 'component/message_tile_factory_component.dart';
export 'mapper/message_tile_mapper.dart';
export 'screen/chat/message_action_listener.dart';
export 'tile/model/tile_model.dart';
export 'tile/widget/tile_widget.dart';
export 'wall/message_wall_context.dart';
export 'widget/chat_context.dart';

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
