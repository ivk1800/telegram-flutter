import 'package:core/core.dart';
import 'package:presentation/src/widget/span/span.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:presentation/src/model/model.dart';
import 'package:jugger/jugger.dart' as j;

class ChatTileModelMapper {
  @j.inject
  ChatTileModelMapper(
      this._chatSpanFormatter, this._dateFormatter, this._dateParser);

  final ChatSpanFormatter _chatSpanFormatter;
  final DateFormatter _dateFormatter;
  final DateParser _dateParser;

  ChatTileModel mapToModel(td.Chat chat) {
    assert(chat.positions.length == 1);
    return ChatTileModel(
        isPinned: chat.positions[0].isPinned,
        lastMessageDate: _dateFormatter.formatChatLastMessageDateOrNull(
            _dateParser.parseUnixTimeStampToDateOrNull(chat.lastMessage?.date)),
        id: chat.id,
        photoId: chat.photo?.small.id,
        title: _chatSpanFormatter.toTitle(chat),
        subtitle: _chatSpanFormatter.toSubtitle(chat));
  }
}
