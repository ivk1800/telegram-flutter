import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/interactor/chat_messages_list_interactor.dart';
import 'package:feature_chat_impl/src/mapper/message_tile_mapper.dart';
import 'package:feature_chat_impl/src/resolver/formatted_text_resolver.dart';
import 'package:feature_chat_impl/src/screen/chat/bloc/chat_bloc.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_page.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message.dart';
import 'package:feature_chat_impl/src/widget/theme/chat_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

import 'messages_tile_factory_factory.dart';

class ChatWidgetFactory implements IChatWidgetFactory {
  ChatWidgetFactory({required this.dependencies});

  final IChatFeatureDependencies dependencies;

  @override
  Widget create(BuildContext context, int chatId) {
    final ChatArgs chatArgs = ChatArgs(chatId);

    final MessagesTileFactoryFactory tileFactoryFactory =
        MessagesTileFactoryFactory();

    final tg.AvatarWidgetFactory avatarWidgetFactory =
        tg.AvatarWidgetFactory(fileRepository: dependencies.fileRepository);
    final ChatMessageFactory chatMessageFactory = ChatMessageFactory(
      avatarWidgetFactory: avatarWidgetFactory,
    );
    final FormattedTextResolver formattedTextResolver = FormattedTextResolver();
    final ShortInfoFactory shortInfoFactory = ShortInfoFactory();
    return MultiProvider(
      providers: <Provider<dynamic>>[
        Provider<tg.TileFactory>.value(
            value: tileFactoryFactory.create(
                shortInfoFactory: shortInfoFactory,
                chatMessageFactory: chatMessageFactory)),
        Provider<ChatMessageFactory>.value(value: chatMessageFactory),
        Provider<ILocalizationManager>.value(
            value: dependencies.localizationManager),
        Provider<tg.ConnectionStateWidgetFactory>.value(
            value: tg.ConnectionStateWidgetFactory(
                connectionStateProvider: dependencies.connectionStateProvider))
      ],
      child: BlocProvider<ChatBloc>(
          create: (BuildContext context) => ChatBloc(
                router: dependencies.router,
                messagesInteractor: ChatMessagesInteractor(
                    chatRepository: dependencies.chatRepository,
                    chatArgs: chatArgs,
                    messageTileMapper: MessageTileMapper(
                        localizationManager: dependencies.localizationManager,
                        formattedTextResolver: formattedTextResolver),
                    messageRepository: dependencies.chatMessageRepository),
                args: chatArgs,
              ),
          child: ChatTheme(
            data: ChatThemeData.light(context: context),
            child: const ChatPage(),
          )),
    );
  }
}
