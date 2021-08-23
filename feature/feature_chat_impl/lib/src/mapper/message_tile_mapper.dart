import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chat_impl/src/mapper/additional_info_mapper.dart';
import 'package:feature_chat_impl/src/mapper/sender_info_mapper.dart';
import 'package:feature_chat_impl/src/resolver/formatted_text_resolver.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tile/tile.dart';

import 'message_call_tile_model_mapper.dart';
import 'message_reply_info_mapper.dart';

class MessageTileMapper {
  MessageTileMapper(
      {required FormattedTextResolver formattedTextResolver,
      required DateParser dateParser,
      required IUserRepository userRepository,
      required SenderInfoMapper senderInfoMapper,
      required MessageReplyInfoMapper messageReplyInfoMapper,
      required AdditionalInfoMapper additionalInfoMapper,
      required ILocalizationManager localizationManager})
      : _localizationManager = localizationManager,
        _userRepository = userRepository,
        _senderInfoMapper = senderInfoMapper,
        _messageReplyInfoMapper = messageReplyInfoMapper,
        _additionalInfoMapper = additionalInfoMapper,
        _messageCallTileModelMapper = MessageCallTileModelMapper(
          additionalInfoMapper: additionalInfoMapper,
          senderInfoResolver: senderInfoMapper,
          localizationManager: localizationManager,
          dateParser: dateParser,
          messageReplyInfoMapper: messageReplyInfoMapper,
        ),
        _formattedTextResolver = formattedTextResolver;

  final SenderInfoMapper _senderInfoMapper;
  final AdditionalInfoMapper _additionalInfoMapper;
  final FormattedTextResolver _formattedTextResolver;
  final ILocalizationManager _localizationManager;
  final MessageReplyInfoMapper _messageReplyInfoMapper;
  final IUserRepository _userRepository;

  final MessageCallTileModelMapper _messageCallTileModelMapper;

  Future<ITileModel> mapToTileModel(td.Message message) async {
    final td.MessageContent content = message.content;
    final String notImplementedText =
        'not implemented ${message.content.runtimeType.toString()}';
    switch (content.getConstructor()) {
      case td.MessageAnimation.CONSTRUCTOR:
        {
          final td.MessageAnimation m = message.content.cast();
          return MessageAnimationTileModel(
            id: message.id,
            senderInfo: await _senderInfoMapper.map(message.sender),
            replyInfo: await _messageReplyInfoMapper.mapToReplyInfo(message),
            additionalInfo: await _additionalInfoMapper.map(message),
            isOutgoing: message.isOutgoing,
            caption: _formattedTextResolver.resolve(m.caption),
            minithumbnail: m.animation.minithumbnail?.toMinithumbnail(),
          );
        }
      case td.MessageAudio.CONSTRUCTOR:
        {
          final td.MessageAudio m = message.content.cast();
          final Duration duration = Duration(seconds: m.audio.duration);
          return MessageAudioTileModel(
              id: message.id,
              senderInfo: await _senderInfoMapper.map(message.sender),
              replyInfo: await _messageReplyInfoMapper.mapToReplyInfo(message),
              additionalInfo: await _additionalInfoMapper.map(message),
              isOutgoing: message.isOutgoing,
              performer: m.audio.performer,
              totalDuration:
                  '${duration.inMinutes.remainder(60)}:${duration.inSeconds.remainder(60)}',
              title: m.audio.title);
        }
      case td.MessageBasicGroupChatCreate.CONSTRUCTOR:
        {
          final td.MessageBasicGroupChatCreate m = message.content.cast();
          return MessageBasicGroupChatCreateTileModel(
              id: message.id,
              // todo add a tap for username
              // todo add username
              text: TextSpan(
                  text: _localizationManager.getStringFormatted(
                      'ActionCreateGroup', <dynamic>['todo'])));
        }
      case td.MessageCall.CONSTRUCTOR:
        {
          return _messageCallTileModelMapper.mapToTileModel(
              message: message, content: message.content.cast());
        }
      case td.MessageChatAddMembers.CONSTRUCTOR:
        {
          final td.MessageChatAddMembers m = message.content.cast();

          final String joinedUserNames =
              (await Stream<int>.fromIterable(m.memberUserIds)
                      .asyncMap((int userId) async {
            final td.User user = await _userRepository.getUser(userId);
            // todo extract to extension for concat first and last names
            return <String>[user.firstName, user.lastName]
                .where((String element) {
              // todo check by isNotBlack
              return element.isNotEmpty;
            }).join(' ');
          }).toList())
                  .join(', ');

          return MessageChatAddMembersTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              title: TextSpan(
                  //todo add taps for users
                  text: _localizationManager.getStringFormatted(
                      'EventLogGroupJoined', <dynamic>[joinedUserNames])));
        }
      case td.MessageChatChangePhoto.CONSTRUCTOR:
        {
          final td.MessageChatChangePhoto m = message.content.cast();
          return MessageChatChangePhotoTileModel(
            id: message.id,
            // todo missing user name
            title: TextSpan(
                text: _getStringFormatted(
                    'ActionChangedPhoto', <dynamic>['todo'])),
            minithumbnail: m.photo.minithumbnail?.toMinithumbnail(),
          );
        }
      case td.MessageChatChangeTitle.CONSTRUCTOR:
        {
          final td.MessageChatChangeTitle m = message.content.cast();
          return MessageChatChangeTitleTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              // todo missing user name
              title: TextSpan(
                  text: _getStringFormatted(
                      'ActionChangedTitle', <dynamic>['todo', m.title])));
        }
      case td.MessageChatDeleteMember.CONSTRUCTOR:
        {
          final td.MessageChatDeleteMember m = message.content.cast();
          final td.User user = await _userRepository.getUser(m.userId);
          return MessageChatDeleteMemberTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              // todo missing user name
              title: TextSpan(
                  text: _getStringFormatted('ActionKickUser', <dynamic>[
                'todo',
                // todo extract to extension for concat first and last names
                (<String>[user.firstName, user.lastName]
                    .where((String element) {
                  // todo check by isNotBlack
                  return element.isNotEmpty;
                }).join(' '))
              ])));
        }
      case td.MessageChatDeletePhoto.CONSTRUCTOR:
        {
          return MessageChatDeletePhotoTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              // todo missing user name
              title: TextSpan(
                  text: _getStringFormatted(
                      'ActionRemovedPhoto', <dynamic>['todo'])));
        }
      case td.MessageChatJoinByLink.CONSTRUCTOR:
        {
          return MessageChatJoinByLinkTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              // todo missing user name
              title: TextSpan(
                  text: _getStringFormatted(
                      'ActionInviteUser', <dynamic>['todo'])));
        }
      case td.MessageChatSetTtl.CONSTRUCTOR:
        {
          final td.MessageChatSetTtl m = message.content.cast();
          // todo format ttl to human string
          return MessageChatSetTtlTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              title: TextSpan(
                  text: message.isOutgoing
                      ? _getStringFormatted(
                          'MessageLifetimeChangedOutgoing', <dynamic>['todo'])
                      : _getStringFormatted('MessageLifetimeChanged',
                          // todo missing user name
                          <dynamic>['todo', 'todo'])));
        }
      case td.MessageChatUpgradeFrom.CONSTRUCTOR:
        {
          final td.MessageChatUpgradeFrom m = message.content.cast();
          return MessageChatUpgradeFromTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              title: TextSpan(
                  text: _getStringFormatted(
                      'ActionMigrateFromGroupNotify', <dynamic>[m.title])));
        }
      case td.MessageChatUpgradeTo.CONSTRUCTOR:
        {
          final td.MessageChatUpgradeTo m = message.content.cast();
          return MessageChatUpgradeFromTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              title: TextSpan(
                  text: _localizationManager
                      .getString('ActionMigrateFromGroup')));
        }
      case td.MessageContactRegistered.CONSTRUCTOR:
        {
          return MessageContactRegisteredTileModel(
              id: message.id,
              isOutgoing: message.isOutgoing,
              title: TextSpan(
                  text: _localizationManager.getString('ContactJoined')));
        }
      case td.MessageContact.CONSTRUCTOR:
        {
          final td.MessageContact m = message.content.cast();
          final td.Contact contact = m.contact;

          // todo extact data from vcard
          return MessageContactTileModel(
            id: message.id,
            senderInfo: await _senderInfoMapper.map(message.sender),
            replyInfo: await _messageReplyInfoMapper.mapToReplyInfo(message),
            additionalInfo: await _additionalInfoMapper.map(message),
            isOutgoing: message.isOutgoing,
            title: // todo extract to extension for concat first and last names
                <String>[contact.firstName, contact.lastName]
                    .where((String element) {
              // todo check by isNotBlack
              return element.isNotEmpty;
            }).join(' '),
            // todo phone number may be missing
            subtitle: contact.phoneNumber,
          );
        }
      case td.MessageCustomServiceAction.CONSTRUCTOR:
        {
          final td.MessageCustomServiceAction m = message.content.cast();
          return MessageCustomServiceActionTileModel(
              id: message.id, isOutgoing: message.isOutgoing, title: m.text);
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
            senderInfo: await _senderInfoMapper.map(message.sender),
            replyInfo: await _messageReplyInfoMapper.mapToReplyInfo(message),
            additionalInfo: await _additionalInfoMapper.map(message),
            minithumbnail: m.photo.minithumbnail?.toMinithumbnail(),
            isOutgoing: message.isOutgoing,
            caption: _formattedTextResolver.resolve(m.caption),
            // todo need preferred size for current screen resolution
            photoId: m.photo.sizes.first.photo.id,
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
              senderInfo: await _senderInfoMapper.map(message.sender),
              replyInfo: await _messageReplyInfoMapper.mapToReplyInfo(message),
              additionalInfo: await _additionalInfoMapper.map(message),
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
            type: notImplementedText,
          );
        }
      case td.MessageVideo.CONSTRUCTOR:
        {
          final td.MessageVideo m = message.content.cast();
          return MessageVideoTileModel(
            id: message.id,
            senderInfo: await _senderInfoMapper.map(message.sender),
            replyInfo: await _messageReplyInfoMapper.mapToReplyInfo(message),
            additionalInfo: await _additionalInfoMapper.map(message),
            isOutgoing: message.isOutgoing,
            caption: _formattedTextResolver.resolve(m.caption),
            minithumbnail: m.video.minithumbnail?.toMinithumbnail(),
            thumbnailImageId: m.video.thumbnail?.file.id,
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

  String _getStringFormatted(String key, List<dynamic> formatArgs) =>
      _localizationManager.getStringFormatted(key, formatArgs);
}

extension ContentExtension on td.MessageContent {
  T cast<T extends td.MessageContent>() => this as T;
}
