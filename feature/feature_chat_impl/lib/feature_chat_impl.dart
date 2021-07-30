library feature_chat_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:localization_api/localization_api.dart';

import 'src/chat_screen_router.dart';
import 'src/widget/factory/chat_screen_factory.dart';

export 'src/chat_screen_router.dart';
export 'src/component/message_mapper_component.dart';
export 'src/component/message_tile_factory_component.dart';
export 'src/mapper/message_tile_mapper.dart';
export 'src/screen/chat/message_action_listener.dart';
export 'src/tile/model/tile_model.dart';
export 'src/tile/widget/tile_widget.dart';
export 'src/wall/message_wall_context.dart';
export 'src/widget/chat_context.dart';
export 'src/widget/theme/chat_theme.dart';

class ChatFeatureApi implements IChatFeatureApi {
  ChatFeatureApi({required this.dependencies})
      : _chatScreenFactory = ChatScreenFactory(dependencies: dependencies);

  final IChatScreenFactory _chatScreenFactory;

  final IChatFeatureDependencies dependencies;

  @override
  IChatScreenFactory get chatScreenFactory => _chatScreenFactory;
}

abstract class IChatFeatureDependencies {
  IChatRepository get chatRepository;

  IFileRepository get fileRepository;

  IUserRepository get userRepository;

  IChatMessageRepository get chatMessageRepository;

  IChatScreenRouter get router;

  DateFormatter get dateFormatter;

  DateParser get dateParser;

  IConnectionStateProvider get connectionStateProvider;

  ILocalizationManager get localizationManager;

  IMessagePreviewResolver get messagePreviewResolver;

  IChatHeaderInfoFeatureApi get chatHeaderInfoFeatureApi;
}
