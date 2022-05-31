import 'package:core_utils/core_utils.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/mapper/sender_info_mapper.dart';
import 'package:intl/intl.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tile/tile.dart';

import 'additional_info_mapper.dart';
import 'message_reply_info_mapper.dart';

class MessageCallTileModelMapper {
  MessageCallTileModelMapper({
    required IStringsProvider stringsProvider,
    required SenderInfoMapper senderInfoResolver,
    required AdditionalInfoMapper additionalInfoMapper,
    required MessageReplyInfoMapper messageReplyInfoMapper,
    required DateParser dateParser,
  })  : _stringsProvider = stringsProvider,
        _senderInfoResolver = senderInfoResolver,
        _additionalInfoMapper = additionalInfoMapper,
        _messageReplyInfoMapper = messageReplyInfoMapper,
        _dateParser = dateParser;

  final DateFormat _callDateFormat = DateFormat('HH:mm');

  final SenderInfoMapper _senderInfoResolver;
  final IStringsProvider _stringsProvider;
  final MessageReplyInfoMapper _messageReplyInfoMapper;
  final AdditionalInfoMapper _additionalInfoMapper;
  final DateParser _dateParser;

  Future<ITileModel> mapToTileModel({
    required td.Message message,
    required td.MessageCall content,
  }) async {
    final DateTime callDate =
        _dateParser.parseUnixTimeStampToDate(message.date);
    // todo handle video calls
    return MessageCallTileModel(
      id: message.id,
      senderInfo: await _senderInfoResolver.map(message.senderId),
      replyInfo: await _messageReplyInfoMapper.mapToReplyInfo(message),
      additionalInfo: await _additionalInfoMapper.map(message),
      isOutgoing: message.isOutgoing,
      duration: _getDuration(content.duration),
      date: _callDateFormat.format(callDate),
      title: _toHumanString(message.isOutgoing, content.discardReason),
    );
  }

  String? _getDuration(int durationSeconds) {
    if (durationSeconds <= 0) {
      return null;
    }

    final Duration duration = Duration(seconds: durationSeconds);

    // TODO plurals for hours and etc.
    return '${duration.inSeconds} seconds';
  }

  String _toHumanString(bool isOutgoing, td.CallDiscardReason reason) {
    switch (reason.getConstructor()) {
      case td.CallDiscardReasonEmpty.constructor:
        {
          //TODO replace by actual text
          return 'todo ???';
        }
      case td.CallDiscardReasonMissed.constructor:
        {
          if (isOutgoing) {
            return _stringsProvider.callMessageOutgoingMissed;
          }
          return _stringsProvider.callMessageIncomingMissed;
        }
      case td.CallDiscardReasonDeclined.constructor:
        {
          if (isOutgoing) {
            return _stringsProvider.callMessageOutgoing;
          }
          return _stringsProvider.callMessageIncomingDeclined;
        }
      case td.CallDiscardReasonDisconnected.constructor:
        {
          //TODO replace by actual text
          return 'todo Disconnected';
        }
      case td.CallDiscardReasonHungUp.constructor:
        {
          if (isOutgoing) {
            return _stringsProvider.callMessageOutgoing;
          }
          return _stringsProvider.callMessageIncoming;
        }
    }
    return '';
  }
}
