import 'package:app/src/util/util.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:flutter/painting.dart';
import 'package:jugger/jugger.dart' as j;

class ChatSpanFormatter {
  @j.inject
  ChatSpanFormatter(this._stringsProvider);

  final IStringsProvider _stringsProvider;

  InlineSpan toTitle(td.Chat chat) {
    return TextSpan(text: chat.title);
  }

  InlineSpan toSubtitle(td.Chat chat) {
    final td.Message? message = chat.lastMessage;
    if (message == null) {
      return const TextSpan(text: '');
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

    return TextSpan(text: '${content.runtimeType}');
  }

  InlineSpan _createForMessageText(td.MessageText message) {
    return TextSpan(text: message.text.text);
  }

  InlineSpan _createForMessageSticker(td.MessageSticker message) {
    return TextSpan(
        text: message.sticker.emoji,
        children: <InlineSpan>[TextSpan(text: _stringsProvider.sticker)]);
  }

  InlineSpan _createForMessagePhoto(td.MessagePhoto message) {
    return TextSpan(
        text: '🖼️ ',
        children: <InlineSpan>[createForFormattedText(message.caption)]);
  }

  InlineSpan createForFormattedText(td.FormattedText text) {
    return TextSpan(text: text.text);
  }
}
