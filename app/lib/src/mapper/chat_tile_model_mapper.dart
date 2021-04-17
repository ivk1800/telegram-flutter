import 'package:core/core.dart';
import 'package:presentation/src/widget/span/span.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:presentation/src/model/model.dart';
import 'package:jugger/jugger.dart' as j;

class ChatTileModelMapper {
  @j.inject
  ChatTileModelMapper(
      {required DateFormatter dateFormatter, required DateParser dateParser})
      : _dateFormatter = dateFormatter,
        _dateParser = dateParser;

  final DateFormatter _dateFormatter;
  final DateParser _dateParser;

  ChatTileModel mapToModel(td.Chat chat) {
    assert(chat.positions.length == 1);
    return ChatTileModel(
      isMuted: chat.notificationSettings.muteFor > 0,
      isOfficial: false,
      unreadMessagesCount: chat.unreadCount,
      isPinned: chat.positions[0].isPinned,
      lastMessageDate: _dateFormatter.formatChatLastMessageDateOrNull(
          _dateParser.parseUnixTimeStampToDateOrNull(chat.lastMessage?.date)),
      id: chat.id,
      photoId: chat.photo?.small.id,
      title: chat.title,
      firstSubtitle: _getFirstSubtitle(chat),
      secondSubtitle: _getSecondSubtitle(chat),
    );
  }

  String? _getFirstSubtitle(td.Chat chat) {
    return null;
  }

  String? _getSecondSubtitle(td.Chat chat) {
    final td.Message? message = chat.lastMessage;
    if (message == null) {
      return null;
    }

    final td.MessageContent content = message.content;
    switch (content.getConstructor()) {
      case td.MessageText.CONSTRUCTOR:
        {
          return _createForMessageText(content as td.MessageText);
        }
      case td.MessageSticker.CONSTRUCTOR:
        {
          return _createForMessageSticker(content as td.MessageSticker);
        }
      case td.MessagePhoto.CONSTRUCTOR:
        {
          return _createForMessagePhoto(content as td.MessagePhoto);
        }
    }

    return content.runtimeType.toString();
  }

  String _createForMessageText(td.MessageText message) {
    return message.text.text;
  }

  String _createForMessageSticker(td.MessageSticker message) {
    return message.sticker.emoji;
  }

  String _createForMessagePhoto(td.MessagePhoto message) {
    return message.caption.text;
  }

  String createForFormattedText(td.FormattedText text) {
    return text.text;
  }
}
