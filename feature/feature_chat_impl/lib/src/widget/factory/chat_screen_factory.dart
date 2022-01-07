import 'package:chat_actions_panel/chat_actions_panel.dart';
import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/di/di.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_page.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:feature_chat_impl/src/screen/chat/view_model/chat_actions_panel_view_model.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:tile/tile.dart';

class ChatScreenFactory implements IChatScreenFactory {
  ChatScreenFactory({required this.dependencies});

  final ChatFeatureDependencies dependencies;

  @override
  Widget create(int chatId) {
    return Provider<ChatScreenComponent>(
      create: (_) => JuggerChatScreenComponentBuilder()
          .dependencies(dependencies)
          .chatArgs(ChatArgs(chatId))
          .build(),
      child: MultiProvider(
        providers: <Provider<dynamic>>[
          Provider<IChatActionPanelFactory>(
            create: (BuildContext context) =>
                context.getComponent().getChatActionPanelFactory(),
          ),
          Provider<TileFactory>(
            create: (BuildContext context) =>
                context.getComponent().getTileFactory(),
          ),
          Provider<ChatMessageFactory>(
            create: (BuildContext context) =>
                context.getComponent().getChatMessageFactory(),
          ),
          Provider<ILocalizationManager>(
            create: (BuildContext context) =>
                context.getComponent().getLocalizationManager(),
          ),
          Provider<IChatHeaderInfoFactory>(
            create: (BuildContext context) =>
                context.getComponent().getChatHeaderInfoFactory(),
          ),
          ViewModelProvider<ChatViewModel>(
            create: (BuildContext context) =>
                context.getComponent().getChatViewModel(),
          ),
          ViewModelProvider<ChatActionsPanelViewModel>(
            create: (BuildContext context) =>
                context.getComponent().getChatActionsPanelViewModel(),
          ),
        ],
        child: const ChatPage(),
      ),
    );
  }
}

extension _ContextExt on BuildContext {
  ChatScreenComponent getComponent() =>
      Provider.of<ChatScreenComponent>(this, listen: false);
}
