import 'package:chat_kit/chat_kit.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';

import 'chat_background_type.dart';

@scope
abstract class IChatBackgroundWidgetShowcaseScopeDelegate {
  ChatBackgroundFactory getChatBackgroundFactory();

  ChatBackgroundType getChatBackgroundType();
}
