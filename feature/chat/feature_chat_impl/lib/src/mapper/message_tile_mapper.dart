import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chat_impl/src/mapper/additional_info_mapper.dart';
import 'package:feature_chat_impl/src/mapper/sender_info_mapper.dart';
import 'package:feature_chat_impl/src/resolver/formatted_text_resolver.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:localization_api/localization_api.dart';
import 'package:rich_text_format/rich_text_format.dart' as rt;
import 'package:shared_models/shared_models.dart';
import 'package:td_api/td_api.dart' as td;
import 'package:tile/tile.dart';

import 'message_call_tile_model_mapper.dart';
import 'message_reply_info_mapper.dart';

class MessageTileMapper {
  MessageTileMapper({
    required FormattedTextResolver formattedTextResolver,
    required DateParser dateParser,
    required IUserRepository userRepository,
    required SenderInfoMapper senderInfoMapper,
    required MessageReplyInfoMapper messageReplyInfoMapper,
    required AdditionalInfoMapper additionalInfoMapper,
    required IStringsProvider stringsProvider,
  })  : _stringsProvider = stringsProvider,
        _userRepository = userRepository,
        _senderInfoMapper = senderInfoMapper,
        _messageReplyInfoMapper = messageReplyInfoMapper,
        _additionalInfoMapper = additionalInfoMapper,
        _messageCallTileModelMapper = MessageCallTileModelMapper(
          additionalInfoMapper: additionalInfoMapper,
          senderInfoResolver: senderInfoMapper,
          stringsProvider: stringsProvider,
          dateParser: dateParser,
          messageReplyInfoMapper: messageReplyInfoMapper,
        ),
        _formattedTextResolver = formattedTextResolver;

  final SenderInfoMapper _senderInfoMapper;
  final AdditionalInfoMapper _additionalInfoMapper;
  final FormattedTextResolver _formattedTextResolver;
  final IStringsProvider _stringsProvider;
  final MessageReplyInfoMapper _messageReplyInfoMapper;
  final IUserRepository _userRepository;

  final MessageCallTileModelMapper _messageCallTileModelMapper;

  Future<ITileModel> mapToTileModel(td.Message message) async {
    final td.MessageContent content = message.content;
    final String notImplementedText =
        'not implemented ${message.content.runtimeType.toString()}';

    return content.map(
      messageAnimation: (td.MessageAnimation value) async {
        return MessageAnimationTileModel(
          id: message.id,
          senderInfo: await _senderInfoMapper.map(message.senderId),
          replyInfo: await _messageReplyInfoMapper.mapToReplyInfo(message),
          additionalInfo: await _additionalInfoMapper.map(message),
          isOutgoing: message.isOutgoing,
          caption: _formattedTextResolver.resolve(value.caption),
          minithumbnail: value.animation.minithumbnail?.toMinithumbnail(),
          width: value.animation.width.toDouble(),
          height: value.animation.height.toDouble(),
          animationFileId: value.animation.animation.id,
        );
      },
      messageAudio: (td.MessageAudio value) async {
        final Duration duration = Duration(seconds: value.audio.duration);
        return MessageAudioTileModel(
          id: message.id,
          senderInfo: await _senderInfoMapper.map(message.senderId),
          replyInfo: await _messageReplyInfoMapper.mapToReplyInfo(message),
          additionalInfo: await _additionalInfoMapper.map(message),
          isOutgoing: message.isOutgoing,
          performer: value.audio.performer,
          totalDuration:
              '${duration.inMinutes.remainder(60)}:${duration.inSeconds.remainder(60)}',
          title: value.audio.title,
        );
      },
      messageBasicGroupChatCreate: (td.MessageBasicGroupChatCreate value) {
        return MessageBasicGroupChatCreateTileModel(
          id: message.id,
          // todo add a tap for username
          // todo add username
          text: rt.RichText.planeText(
            _stringsProvider.actionCreateGroup(<dynamic>['todo']),
          ),
        );
      },
      messageCall: (td.MessageCall value) {
        return _messageCallTileModelMapper.mapToTileModel(
          message: message,
          content: message.content.cast(),
        );
      },
      messageChatAddMembers: (td.MessageChatAddMembers value) async {
        final String joinedUserNames =
            (await Stream<int>.fromIterable(value.memberUserIds)
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
          title: rt.RichText.planeText(
            _stringsProvider.eventLogGroupJoined(<dynamic>[joinedUserNames]),
          ),
        );
      },
      messageChatChangePhoto: (td.MessageChatChangePhoto value) {
        return MessageChatChangePhotoTileModel(
          id: message.id,
          // todo missing user name
          title: rt.RichText.planeText(
            _stringsProvider.actionChangedPhoto(<dynamic>['todo']),
          ),
          minithumbnail: value.photo.minithumbnail?.toMinithumbnail(),
        );
      },
      messageChatChangeTitle: (td.MessageChatChangeTitle value) {
        return MessageChatChangeTitleTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          // todo missing user name
          title: rt.RichText.planeText(
            _stringsProvider.actionChangedTitle(
              <dynamic>['todo', value.title],
            ),
          ),
        );
      },
      messageChatDeleteMember: (td.MessageChatDeleteMember value) async {
        final td.User user = await _userRepository.getUser(value.userId);
        return MessageChatDeleteMemberTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          // todo missing user name
          title: rt.RichText.planeText(
            _stringsProvider.actionKickUser(
              <dynamic>[
                'todo',
                // todo extract to extension for concat first and last names
                <String>[user.firstName, user.lastName].where((String element) {
                  // todo check by isNotBlack
                  return element.isNotEmpty;
                }).join(' '),
              ],
            ),
          ),
        );
      },
      messageChatDeletePhoto: (td.MessageChatDeletePhoto value) {
        return MessageChatDeletePhotoTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          // todo missing user name
          title: rt.RichText.planeText(
            _stringsProvider.actionRemovedPhoto(<dynamic>['todo']),
          ),
        );
      },
      messageChatJoinByLink: (td.MessageChatJoinByLink value) {
        return MessageChatJoinByLinkTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          // todo missing user name
          title: rt.RichText.planeText(
            _stringsProvider.actionInviteUser(<dynamic>['todo']),
          ),
        );
      },
      messageChatUpgradeFrom: (td.MessageChatUpgradeFrom value) {
        return MessageChatUpgradeFromTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          title: rt.RichText.planeText(
            _stringsProvider.actionMigrateFromGroupNotify(
              <dynamic>[value.title],
            ),
          ),
        );
      },
      messageChatUpgradeTo: (td.MessageChatUpgradeTo value) {
        return MessageChatUpgradeFromTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          title: rt.RichText.planeText(
            _stringsProvider.actionMigrateFromGroup,
          ),
        );
      },
      messageContactRegistered: (td.MessageContactRegistered value) {
        return MessageContactRegisteredTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          title: rt.RichText.planeText(
            _stringsProvider.actionMigrateFromGroup,
          ),
        );
      },
      messageContact: (td.MessageContact value) async {
        final td.Contact contact = value.contact;

        // todo extact data from vcard
        return MessageContactTileModel(
          id: message.id,
          senderInfo: await _senderInfoMapper.map(message.senderId),
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
      },
      messageCustomServiceAction: (td.MessageCustomServiceAction value) {
        return MessageCustomServiceActionTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          title: rt.RichText.planeText(value.text),
        );
      },
      messageDice: (td.MessageDice value) {
        return MessageDiceTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageDocument: (td.MessageDocument value) {
        return MessageDocumentTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageExpiredPhoto: (td.MessageExpiredPhoto value) {
        return MessageExpiredPhotoTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageExpiredVideo: (td.MessageExpiredVideo value) {
        return MessageExpiredVideoTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageGameScore: (td.MessageGameScore value) {
        return MessageGameScoreTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageGame: (td.MessageGame value) {
        return MessageGameTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageInvoice: (td.MessageInvoice value) {
        return MessageInvoiceTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageLocation: (td.MessageLocation value) {
        return MessageLocationTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messagePassportDataReceived: (td.MessagePassportDataReceived value) {
        return MessagePassportDataReceivedTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messagePassportDataSent: (td.MessagePassportDataSent value) {
        return MessagePassportDataSentTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messagePaymentSuccessfulBot: (td.MessagePaymentSuccessfulBot value) {
        return MessagePaymentSuccessfulBotTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messagePaymentSuccessful: (td.MessagePaymentSuccessful value) {
        return MessagePaymentSuccessfulTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messagePhoto: (td.MessagePhoto value) async {
        final td.PhotoSize photoSize = value.photo.sizes.first;
        return MessagePhotoTileModel(
          id: message.id,
          senderInfo: await _senderInfoMapper.map(message.senderId),
          replyInfo: await _messageReplyInfoMapper.mapToReplyInfo(message),
          additionalInfo: await _additionalInfoMapper.map(message),
          minithumbnail: value.photo.minithumbnail?.toMinithumbnail(),
          isOutgoing: message.isOutgoing,
          caption: _formattedTextResolver.resolve(value.caption),
          // todo need preferred size for current screen resolution
          photoId: photoSize.photo.id,
          photoSize: Size(
            width: photoSize.width.toDouble(),
            height: photoSize.height.toDouble(),
          ),
        );
      },
      messagePinMessage: (td.MessagePinMessage value) {
        return MessagePinMessageTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messagePoll: (td.MessagePoll value) {
        return MessagePollTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageProximityAlertTriggered:
          (td.MessageProximityAlertTriggered value) {
        return MessageProximityAlertTriggeredTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageScreenshotTaken: (td.MessageScreenshotTaken value) {
        return MessageScreenshotTakenTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageSticker: (td.MessageSticker value) {
        return MessageStickerTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          stickerFileId: value.sticker.sticker.id,
          setId: value.sticker.setId,
          // TODO: support more types
          isAnimated: value.sticker.format is td.StickerFormatTgs,
        );
      },
      messageSupergroupChatCreate: (td.MessageSupergroupChatCreate value) {
        return MessageSupergroupChatCreateTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageText: (td.MessageText value) async {
        return MessageTextTileModel(
          id: message.id,
          senderInfo: await _senderInfoMapper.map(message.senderId),
          replyInfo: await _messageReplyInfoMapper.mapToReplyInfo(message),
          additionalInfo: await _additionalInfoMapper.map(message),
          isOutgoing: message.isOutgoing,
          // todo text can be null
          text: _formattedTextResolver.resolve(value.text)!,
        );
      },
      messageUnsupported: (td.MessageUnsupported value) {
        return MessageUnsupportedTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageVenue: (td.MessageVenue value) {
        return MessageVenueTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageVideoNote: (td.MessageVideoNote value) {
        return MessageVideoNoteTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageVideo: (td.MessageVideo value) async {
        return MessageVideoTileModel(
          id: message.id,
          senderInfo: await _senderInfoMapper.map(message.senderId),
          replyInfo: await _messageReplyInfoMapper.mapToReplyInfo(message),
          additionalInfo: await _additionalInfoMapper.map(message),
          isOutgoing: message.isOutgoing,
          caption: _formattedTextResolver.resolve(value.caption),
          minithumbnail: value.video.minithumbnail?.toMinithumbnail(),
          thumbnailImageId: value.video.thumbnail?.file.id,
        );
      },
      messageVoiceNote: (td.MessageVoiceNote value) {
        return MessageVoiceNoteTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageWebsiteConnected: (td.MessageWebsiteConnected value) {
        return MessageWebsiteConnectedTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageVideoChatStarted: (td.MessageVideoChatStarted value) {
        return MessageVideoChatStartedTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageChatSetTheme: (td.MessageChatSetTheme value) {
        return MessageChatSetThemeTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageInviteVideoChatParticipants:
          (td.MessageInviteVideoChatParticipants value) {
        return MessageInviteVideoChatParticipantsTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageAnimatedEmoji: (td.MessageAnimatedEmoji value) async {
        final td.Sticker? sticker = value.animatedEmoji.sticker;
        // TODO: handle nullable sticker
        assert(sticker != null);
        return MessageAnimatedEmojiTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          additionalInfo: await _additionalInfoMapper.map(message),
          senderInfo: await _senderInfoMapper.map(message.senderId),
          replyInfo: await _messageReplyInfoMapper.mapToReplyInfo(message),
          // TODO: Fix emoji
          customEmojiId: 0,
        );
      },
      messageVideoChatScheduled: (td.MessageVideoChatScheduled value) {
        return MessageVideoChatScheduledTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageVideoChatEnded: (td.MessageVideoChatEnded value) {
        return MessageVideoChatEndedTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageChatJoinByRequest: (td.MessageChatJoinByRequest value) {
        return MessageChatJoinByRequestTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageWebAppDataReceived: (td.MessageWebAppDataReceived value) {
        return MessageWebAppDataReceivedTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageWebAppDataSent: (td.MessageWebAppDataSent value) {
        return MessageWebAppDataSentTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageGiftedPremium: (td.MessageGiftedPremium value) {
        return MessageGiftedPremiumTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageForumTopicCreated: (td.MessageForumTopicCreated value) {
        return MessageForumTopicCreatedTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageForumTopicEdited: (td.MessageForumTopicEdited value) {
        return MessageForumTopicEditedTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageForumTopicIsClosedToggled: (
        td.MessageForumTopicIsClosedToggled value,
      ) {
        return MessageForumTopicClosedTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageForumTopicIsHiddenToggled: (
        td.MessageForumTopicIsHiddenToggled value,
      ) {
        return MessageForumTopicIsHiddenTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageChatSetMessageAutoDeleteTime:
          (td.MessageChatSetMessageAutoDeleteTime value) {
        return MessageForumTopicIsHiddenTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageSuggestProfilePhoto: (td.MessageSuggestProfilePhoto value) {
        return MessageForumTopicIsHiddenTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageUserShared: (td.MessageUserShared value) {
        return MessageForumTopicIsHiddenTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageChatShared: (td.MessageChatShared value) {
        return MessageForumTopicIsHiddenTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
      messageBotWriteAccessAllowed: (td.MessageBotWriteAccessAllowed value) {
        return MessageForumTopicIsHiddenTileModel(
          id: message.id,
          isOutgoing: message.isOutgoing,
          type: notImplementedText,
        );
      },
    );
  }
}

extension ContentExtension on td.MessageContent {
  T cast<T extends td.MessageContent>() => this as T;
}
