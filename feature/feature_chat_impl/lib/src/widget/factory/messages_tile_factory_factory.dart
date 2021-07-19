import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/tile/widget/tile_widget.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message.dart';
import 'package:localization_api/localization_api.dart';

// FactoryFactory :)
class MessagesTileFactoryFactory {
  tg.TileFactory create(
      {required ChatMessageFactory chatMessageFactory,
      required ILocalizationManager localizationManager,
      required ShortInfoFactory shortInfoFactory}) {
    return tg
        .TileFactory(delegates: <Type, tg.ITileFactoryDelegate<tg.ITileModel>>{
      MessageAnimationTileModel: MessageAnimationTileFactoryDelegate(
          chatMessageFactory: chatMessageFactory),
      MessageAudioTileModel: MessageAudioTileFactoryDelegate(
          shortInfoFactory: shortInfoFactory,
          chatMessageFactory: chatMessageFactory),
      MessageBasicGroupChatCreateTileModel:
          MessageBasicGroupChatCreateTileFactoryDelegate(
              chatMessageFactory: chatMessageFactory),
      MessageCallTileModel: MessageCallTileFactoryDelegate(
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
