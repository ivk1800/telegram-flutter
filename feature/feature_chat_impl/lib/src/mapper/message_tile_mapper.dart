import 'dart:convert';

import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/util/minithumbnail.dart';
import 'package:flutter/cupertino.dart';
import 'package:tdlib/td_api.dart' as td;

class MessageTileMapper {
  ITileModel mapToTileModel(td.Message message) {
    final td.MessageContent content = message.content;
    final String notImplementedText =
        'not implemented ${message.content.runtimeType.toString()}';
    switch (content.getConstructor()) {
      case td.MessageAnimation.CONSTRUCTOR:
        {
          final td.MessageAnimation m = message.content.cast();
          return MessageAnimationTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageAudio.CONSTRUCTOR:
        {
          final td.MessageAudio m = message.content.cast();
          return MessageAudioTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageBasicGroupChatCreate.CONSTRUCTOR:
        {
          final td.MessageBasicGroupChatCreate m = message.content.cast();
          return MessageBasicGroupChatCreateTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageCall.CONSTRUCTOR:
        {
          final td.MessageCall m = message.content.cast();
          return MessageCallTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageChatAddMembers.CONSTRUCTOR:
        {
          final td.MessageChatAddMembers m = message.content.cast();
          return MessageChatAddMembersTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageChatChangePhoto.CONSTRUCTOR:
        {
          final td.MessageChatChangePhoto m = message.content.cast();
          return MessageChatChangePhotoTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageChatChangeTitle.CONSTRUCTOR:
        {
          final td.MessageChatChangeTitle m = message.content.cast();
          return MessageChatChangeTitleTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageChatDeleteMember.CONSTRUCTOR:
        {
          final td.MessageChatDeleteMember m = message.content.cast();
          return MessageChatDeleteMemberTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageChatDeletePhoto.CONSTRUCTOR:
        {
          final td.MessageChatDeletePhoto m = message.content.cast();
          return MessageChatDeletePhotoTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageChatJoinByLink.CONSTRUCTOR:
        {
          final td.MessageChatJoinByLink m = message.content.cast();
          return MessageChatJoinByLinkTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageChatSetTtl.CONSTRUCTOR:
        {
          final td.MessageChatSetTtl m = message.content.cast();
          return MessageChatSetTtlTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageChatUpgradeFrom.CONSTRUCTOR:
        {
          final td.MessageChatUpgradeFrom m = message.content.cast();
          return MessageChatUpgradeFromTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageChatUpgradeTo.CONSTRUCTOR:
        {
          final td.MessageChatUpgradeTo m = message.content.cast();
          return MessageChatUpgradeToTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageContactRegistered.CONSTRUCTOR:
        {
          final td.MessageContactRegistered m = message.content.cast();
          return MessageContactRegisteredTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageContact.CONSTRUCTOR:
        {
          final td.MessageContact m = message.content.cast();
          return MessageContactTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageCustomServiceAction.CONSTRUCTOR:
        {
          final td.MessageCustomServiceAction m = message.content.cast();
          return MessageCustomServiceActionTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageDice.CONSTRUCTOR:
        {
          final td.MessageDice m = message.content.cast();
          return MessageDiceTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageDocument.CONSTRUCTOR:
        {
          final td.MessageDocument m = message.content.cast();
          return MessageDocumentTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageExpiredPhoto.CONSTRUCTOR:
        {
          final td.MessageExpiredPhoto m = message.content.cast();
          return MessageExpiredPhotoTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageExpiredVideo.CONSTRUCTOR:
        {
          final td.MessageExpiredVideo m = message.content.cast();
          return MessageExpiredVideoTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageGameScore.CONSTRUCTOR:
        {
          final td.MessageGameScore m = message.content.cast();
          return MessageGameScoreTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageGame.CONSTRUCTOR:
        {
          final td.MessageGame m = message.content.cast();
          return MessageGameTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageInviteVoiceChatParticipants.CONSTRUCTOR:
        {
          final td.MessageInviteVoiceChatParticipants m =
              message.content.cast();
          return MessageInviteVoiceChatParticipantsTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageInvoice.CONSTRUCTOR:
        {
          final td.MessageInvoice m = message.content.cast();
          return MessageInvoiceTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageLocation.CONSTRUCTOR:
        {
          final td.MessageLocation m = message.content.cast();
          return MessageLocationTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessagePassportDataReceived.CONSTRUCTOR:
        {
          final td.MessagePassportDataReceived m = message.content.cast();
          return MessagePassportDataReceivedTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessagePassportDataSent.CONSTRUCTOR:
        {
          final td.MessagePassportDataSent m = message.content.cast();
          return MessagePassportDataSentTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessagePaymentSuccessfulBot.CONSTRUCTOR:
        {
          final td.MessagePaymentSuccessfulBot m = message.content.cast();
          return MessagePaymentSuccessfulBotTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessagePaymentSuccessful.CONSTRUCTOR:
        {
          final td.MessagePaymentSuccessful m = message.content.cast();
          return MessagePaymentSuccessfulTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessagePhoto.CONSTRUCTOR:
        {
          final td.MessagePhoto m = message.content.cast();
          return MessagePhotoTileModel(
            id: message.id,
            minithumbnail: m.photo.minithumbnail?.toMinithumbnail(),
            isOutgoing: message.isOutgoing,
          );
        }
      case td.MessagePinMessage.CONSTRUCTOR:
        {
          final td.MessagePinMessage m = message.content.cast();
          return MessagePinMessageTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessagePoll.CONSTRUCTOR:
        {
          final td.MessagePoll m = message.content.cast();
          return MessagePollTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageProximityAlertTriggered.CONSTRUCTOR:
        {
          final td.MessageProximityAlertTriggered m = message.content.cast();
          return MessageProximityAlertTriggeredTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageScreenshotTaken.CONSTRUCTOR:
        {
          final td.MessageScreenshotTaken m = message.content.cast();
          return MessageScreenshotTakenTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageSticker.CONSTRUCTOR:
        {
          final td.MessageSticker m = message.content.cast();
          return MessageStickerTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageSupergroupChatCreate.CONSTRUCTOR:
        {
          final td.MessageSupergroupChatCreate m = message.content.cast();
          return MessageSupergroupChatCreateTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageText.CONSTRUCTOR:
        {
          final td.MessageText m = message.content.cast();
          return MessageTextTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              text: TextSpan(text: m.text.text));
        }
      case td.MessageUnsupported.CONSTRUCTOR:
        {
          final td.MessageUnsupported m = message.content.cast();
          return MessageUnsupportedTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageVenue.CONSTRUCTOR:
        {
          final td.MessageVenue m = message.content.cast();
          return MessageVenueTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageVideoNote.CONSTRUCTOR:
        {
          final td.MessageVideoNote m = message.content.cast();
          return MessageVideoNoteTileModel(
            id: message.id,
            isOutgoing: message.isOutgoing,
            minithumbnail: m.videoNote.minithumbnail?.toMinithumbnail(),
          );
        }
      case td.MessageVoiceChatEnded.CONSTRUCTOR:
        {
          final td.MessageVoiceChatEnded m = message.content.cast();
          return MessageVoiceChatEndedTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageVoiceChatStarted.CONSTRUCTOR:
        {
          final td.MessageVoiceChatStarted m = message.content.cast();
          return MessageVoiceChatStartedTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageVoiceNote.CONSTRUCTOR:
        {
          final td.MessageVoiceNote m = message.content.cast();
          return MessageVoiceNoteTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
      case td.MessageWebsiteConnected.CONSTRUCTOR:
        {
          final td.MessageWebsiteConnected m = message.content.cast();
          return MessageWebsiteConnectedTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              type: notImplementedText);
        }
    }

    return UnknownMessageTileModel(
        id: message.id,
        isOutgoing: message.isOutgoing,
        type: notImplementedText);
  }
}

extension ContentExtension on td.MessageContent {
  T cast<T extends td.MessageContent>() => this as T;
}

extension MinithumbnailExtensions on td.Minithumbnail {
  Minithumbnail? toMinithumbnail() {
    if (this != null) {
      return Minithumbnail(
          data: const Base64Decoder().convert(data),
          width: width.toDouble(),
          height: height.toDouble());
    }
  }
}
