import 'package:chat_actions_panel/chat_actions_panel.dart';
import 'package:chat_kit/chat_kit.dart';
import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:localization_api/localization_api.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';

import 'chat_screen.dart';
import 'chat_widget_model.dart';
import 'empty_chat/empty_chat_widget_factory.dart';
import 'message_factory.dart';

@scope
abstract class IChatScreenScopeDelegate implements ScopeDisposer {
  ChatActionPanelFactory getChatActionPanelFactory();

  MessageFactory getMessageFactory();

  IStringsProvider getStringsProvider();

  IChatHeaderInfoFactory getChatHeaderInfoFactory();

  ChatMessagesViewModel getChatMessagesViewModel();

  ChatActionBarViewModel getChatActionBarModel();

  ChatWidgetModel getChatWidgetModel();

  EmptyChatWidgetFactory getEmptyChatWidgetFactory();

  ChatBackgroundFactory getChatBackgroundFactory();
}
