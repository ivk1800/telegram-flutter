import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/resolver/message_component_resolver.dart';
import 'package:feature_chat_impl/src/wall/message_wall_context.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/tile/widget/tile_widget.dart';
import 'package:feature_chat_impl/src/widget/chat_message/sender_avatar_factory.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:localization_api/localization_api.dart';

// FactoryFactory :)
class MessagesTileFactoryFactory {
  tg.TileFactory create(
      {required ChatMessageFactory chatMessageFactory,
      required ILocalizationManager localizationManager,
      required ReplyInfoFactory replyInfoFactory,
      required SenderTitleFactory senderTitleFactory,
      required SenderAvatarFactory senderAvatarFactory,
      required MessageComponentResolver messageComponentResolver,
      required IMessageWallContext messageWallContext,
      required ShortInfoFactory shortInfoFactory}) {
    return tg
        .TileFactory(delegates: <Type, tg.ITileFactoryDelegate<tg.ITileModel>>{
      MessageAnimationTileModel: MessageAnimationTileFactoryDelegate(
          shortInfoFactory: shortInfoFactory,
          senderAvatarFactory: senderAvatarFactory,
          senderTitleFactory: senderTitleFactory,
          replyInfoFactory: replyInfoFactory,
          chatMessageFactory: chatMessageFactory),
      MessageAudioTileModel: MessageAudioTileFactoryDelegate(
          senderTitleFactory: senderTitleFactory,
          replyInfoFactory: replyInfoFactory,
          senderAvatarFactory: senderAvatarFactory,
          shortInfoFactory: shortInfoFactory,
          chatMessageFactory: chatMessageFactory),
      MessageBasicGroupChatCreateTileModel:
          MessageBasicGroupChatCreateTileFactoryDelegate(
              chatMessageFactory: chatMessageFactory),
      MessageCallTileModel: MessageCallTileFactoryDelegate(
          senderTitleFactory: senderTitleFactory,
          senderAvatarFactory: senderAvatarFactory,
          replyInfoFactory: replyInfoFactory,
          chatMessageFactory: chatMessageFactory),
      MessageChatAddMembersTileModel: MessageChatAddMembersTileFactoryDelegate(
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
      MessageChatJoinByLinkTileModel: MessageChatJoinByLinkTileFactoryDelegate(
          chatMessageFactory: chatMessageFactory),
      MessageChatSetTtlTileModel: MessageChatSetTtlTileFactoryDelegate(
          chatMessageFactory: chatMessageFactory),
      MessageChatUpgradeFromTileModel:
          MessageChatUpgradeFromTileFactoryDelegate(
              chatMessageFactory: chatMessageFactory),
      MessageChatUpgradeToTileModel: MessageChatUpgradeToTileFactoryDelegate(
          chatMessageFactory: chatMessageFactory),
      MessageContactTileModel: MessageContactTileFactoryDelegate(
          senderTitleFactory: senderTitleFactory,
          replyInfoFactory: replyInfoFactory,
          senderAvatarFactory: senderAvatarFactory,
          localizationManager: localizationManager,
          shortInfoFactory: shortInfoFactory,
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
      MessageExpiredPhotoTileModel: MessageExpiredPhotoTileFactoryDelegate(
          chatMessageFactory: chatMessageFactory),
      MessageExpiredVideoTileModel: MessageExpiredVideoTileFactoryDelegate(
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
          shortInfoFactory: shortInfoFactory,
          senderAvatarFactory: senderAvatarFactory,
          senderTitleFactory: senderTitleFactory,
          replyInfoFactory: replyInfoFactory,
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
          messageComponentResolver: messageComponentResolver,
          shortInfoFactory: shortInfoFactory,
          replyInfoFactory: replyInfoFactory,
          chatMessageFactory: chatMessageFactory),
      MessageUnsupportedTileModel: MessageUnsupportedTileFactoryDelegate(
          chatMessageFactory: chatMessageFactory),
      MessageVenueTileModel: MessageVenueTileFactoryDelegate(
          chatMessageFactory: chatMessageFactory),
      MessageVideoNoteTileModel: MessageVideoNoteTileFactoryDelegate(
          chatMessageFactory: chatMessageFactory),
      MessageVideoTileModel: MessageVideoTileFactoryDelegate(
          shortInfoFactory: shortInfoFactory,
          senderAvatarFactory: senderAvatarFactory,
          senderTitleFactory: senderTitleFactory,
          replyInfoFactory: replyInfoFactory,
          chatMessageFactory: chatMessageFactory),
      MessageVoiceChatEndedTileModel: MessageVoiceChatEndedTileFactoryDelegate(
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
    });
  }
}
