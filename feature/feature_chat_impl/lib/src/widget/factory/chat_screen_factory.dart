import 'package:chat_actions_panel/chat_actions_panel.dart';
import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/di/di.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_page.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:feature_chat_impl/src/screen/chat/message_factory.dart';
import 'package:feature_chat_impl/src/screen/chat/view_model/chat_actions_panel_view_model.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:provider_extensions/provider_extensions.dart';

class ChatScreenFactory implements IChatScreenFactory {
  ChatScreenFactory({required this.dependencies});

  final ChatFeatureDependencies dependencies;

  @override
  Widget create(int chatId) {
    return Scope<IChatScreenComponent>(
      create: () => JuggerChatScreenComponentBuilder()
          .dependencies(dependencies)
          .chatArgs(ChatArgs(chatId))
          .build(),
      providers: (IChatScreenComponent component) {
        return <Provider<dynamic>>[
          Provider<IChatActionPanelFactory>(
            create: (_) => component.getChatActionPanelFactory(),
          ),
          Provider<MessageFactory>(
            create: (_) => component.getMessageFactory(),
          ),
          Provider<ChatMessageFactory>(
            create: (_) => component.getChatMessageFactory(),
          ),
          Provider<ILocalizationManager>(
            create: (_) => component.getLocalizationManager(),
          ),
          Provider<IChatHeaderInfoFactory>(
            create: (_) => component.getChatHeaderInfoFactory(),
          ),
          ViewModelProvider<ChatViewModel>(
            create: (_) => component.getChatViewModel(),
          ),
          ViewModelProvider<ChatActionsPanelViewModel>(
            create: (_) => component.getChatActionsPanelViewModel(),
          ),
        ];
      },
      child: const ChatPage(),
    );
  }
}
