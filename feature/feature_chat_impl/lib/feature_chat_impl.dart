library feature_chat_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:localization_api/localization_api.dart';
import 'src/chat_screen_router.dart';
import 'src/widget/factory/chat_widget_factory.dart';

export 'src/chat_screen_router.dart';

export 'src/widget/bubble/bubble.dart';
export 'src/widget/bubble/bubble_clipper.dart';
export 'src/widget/message/message_skeleton.dart';

class ChatFeatureApi implements IChatFeatureApi {
  ChatFeatureApi({required this.dependencies})
      : _chatWidgetFactory = ChatWidgetFactory(dependencies: dependencies);

  final IChatWidgetFactory _chatWidgetFactory;

  final IChatFeatureDependencies dependencies;

  @override
  IChatWidgetFactory get screenWidgetFactory => _chatWidgetFactory;
}

abstract class IChatFeatureDependencies {
  IChatRepository get chatRepository;

  IFileRepository get fileRepository;

  IChatMessageRepository get chatMessageRepository;

  IChatScreenRouter get router;

  DateFormatter get dateFormatter;

  DateParser get dateParser;

  IConnectionStateProvider get connectionStateProvider;

  ILocalizationManager get localizationManager;
}
