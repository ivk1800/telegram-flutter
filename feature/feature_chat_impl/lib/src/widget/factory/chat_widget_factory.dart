import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/interactor/chat_messages_list_interactor.dart';
import 'package:feature_chat_impl/src/mapper/message_tile_mapper.dart';
import 'package:feature_chat_impl/src/resolver/formatted_text_resolver.dart';
import 'package:feature_chat_impl/src/screen/chat/bloc/chat_bloc.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_page.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/tile/widget/tile_widget.dart';
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
    return MultiProvider(
      providers: <Provider<dynamic>>[
        Provider<tg.TileFactory>.value(
            value: tileFactoryFactory.create(
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

  Provider<tg.TileFactory> _createTileFactoryProvider(
          {required ChatMessageFactory chatMessageFactory}) =>
      Provider<tg.TileFactory>.value(
          value: tg.TileFactory(
              delegates: <Type, tg.ITileFactoryDelegate<tg.ITileModel>>{
            MessageAnimationTileModel: MessageAnimationTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageAudioTileModel: MessageAudioTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageBasicGroupChatCreateTileModel:
                MessageBasicGroupChatCreateTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageCallTileModel: MessageCallTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageChatAddMembersTileModel:
                MessageChatAddMembersTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageChatChangePhotoTileModel:
                MessageChatChangePhotoTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageChatChangeTitleTileModel:
                MessageChatChangeTitleTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageChatDeleteMemberTileModel:
                MessageChatDeleteMemberTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageChatDeletePhotoTileModel:
                MessageChatDeletePhotoTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageChatJoinByLinkTileModel:
                MessageChatJoinByLinkTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageChatSetTtlTileModel: MessageChatSetTtlTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageChatUpgradeFromTileModel:
                MessageChatUpgradeFromTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageChatUpgradeToTileModel:
                MessageChatUpgradeToTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageContactTileModel: MessageContactTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageContactRegisteredTileModel:
                MessageContactRegisteredTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageCustomServiceActionTileModel:
                MessageCustomServiceActionTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageDiceTileModel: MessageDiceTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageDocumentTileModel: MessageDocumentTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageExpiredPhotoTileModel:
                MessageExpiredPhotoTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageExpiredVideoTileModel:
                MessageExpiredVideoTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageGameScoreTileModel: MessageGameScoreTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageGameTileModel: MessageGameTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageInviteVoiceChatParticipantsTileModel:
                MessageInviteVoiceChatParticipantsTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageInvoiceTileModel: MessageInvoiceTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageLocationTileModel: MessageLocationTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessagePassportDataReceivedTileModel:
                MessagePassportDataReceivedTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessagePassportDataSentTileModel:
                MessagePassportDataSentTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessagePaymentSuccessfulBotTileModel:
                MessagePaymentSuccessfulBotTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessagePaymentSuccessfulTileModel:
                MessagePaymentSuccessfulTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessagePhotoTileModel: MessagePhotoTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessagePinMessageTileModel: MessagePinMessageTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessagePollTileModel: MessagePollTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageProximityAlertTriggeredTileModel:
                MessageProximityAlertTriggeredTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageScreenshotTakenTileModel:
                MessageScreenshotTakenTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageStickerTileModel: MessageStickerTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageSupergroupChatCreateTileModel:
                MessageSupergroupChatCreateTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageTextTileModel: MessageTextTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageUnsupportedTileModel: MessageUnsupportedTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageVenueTileModel: MessageVenueTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageVideoNoteTileModel: MessageVideoNoteTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageVideoTileModel: MessageVideoTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageVoiceChatEndedTileModel:
                MessageVoiceChatEndedTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageVoiceChatStartedTileModel:
                MessageVoiceChatStartedTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            MessageVoiceNoteTileModel: MessageVoiceNoteTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
            MessageWebsiteConnectedTileModel:
                MessageWebsiteConnectedTileFactoryDelegate(
                    chatMessageFactory: chatMessageFactory),
            UnknownMessageTileModel: UnknownMessageTileFactoryDelegate(
                chatMessageFactory: chatMessageFactory),
          }));
}
