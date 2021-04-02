import 'package:presentation/src/widget/span/span.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:presentation/src/model/model.dart';
import 'package:jugger/jugger.dart' as j;

class ChatTileModelMapper {
  @j.inject
  ChatTileModelMapper(this._chatSpanFormatter);

  final ChatSpanFormatter _chatSpanFormatter;

  ChatTileModel mapToModel(td.Chat chat) {
    return ChatTileModel(
        chat: chat,
        id: chat.id,
        photoId: chat.photo?.small.id,
        title: _chatSpanFormatter.toTitle(chat),
        subtitle: _chatSpanFormatter.toSubtitle(chat));
  }
}
