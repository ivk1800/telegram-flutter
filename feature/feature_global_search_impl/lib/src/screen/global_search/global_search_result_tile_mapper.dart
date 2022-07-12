import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:flutter/painting.dart';
import 'package:shared_models/shared_models.dart';
import 'package:td_api/td_api.dart' as td;
import 'package:tile/tile.dart';

import 'tile/model/model.dart';

class GlobalSearchResultTileMapper {
  GlobalSearchResultTileMapper({
    required IChatRepository chatRepository,
  }) : _chatRepository = chatRepository;

  final IChatRepository _chatRepository;

  Future<ITileModel> mapToChatTileModel(td.Chat chat) async {
    return ChatResultTileModel(
      chatId: chat.id,
      avatar: Avatar(
        abbreviation: getAvatarAbbreviation(first: chat.title, second: ''),
        imageFileId: chat.photo?.small.id,
        objectId: chat.id,
      ),
      title: TextSpan(text: chat.title),
      subtitle: TextSpan(text: chat.title),
    );
  }

  Future<ITileModel> mapToMediaTileModel(td.Message message) async {
    final td.Chat chat = await _chatRepository.getChat(message.chatId);
    return MediaResultTileModel(
      chatId: message.chatId,
      avatar: Avatar(
        abbreviation: getAvatarAbbreviation(first: chat.title, second: ''),
        objectId: message.chatId,
        imageFileId: chat.photo?.small.id,
      ),
      title: TextSpan(text: chat.title),
      subtitle: TextSpan(text: message.content.getFormattedText()!.text),
    );
  }

  Future<ITileModel> mapToLinkTileModel(td.Message message) async {
    // todo implement model
    return const LinkResultTileModel();
  }

  Future<ITileModel> mapToFileTileModel(td.Message message) async {
    // todo implement model
    return const FileResultTileModel();
  }

  Future<ITileModel> mapToMusicTileModel(td.Message message) async {
    // todo implement model
    return const MusicResultTileModel();
  }

  Future<ITileModel> mapToVoiceTileModel(td.Message message) async {
    // todo implement model
    return const VoiceResultTileModel();
  }
}

extension _MessageContentExt on td.MessageContent {
  td.FormattedText? getFormattedText() {
    switch (runtimeType) {
      case td.MessageVoiceNote:
        {
          return (this as td.MessageVoiceNote).caption;
        }
      case td.MessageVideo:
        {
          return (this as td.MessageVideo).caption;
        }
      case td.MessagePhoto:
        {
          return (this as td.MessagePhoto).caption;
        }
      case td.MessageDocument:
        {
          return (this as td.MessageDocument).caption;
        }
      case td.MessageAnimation:
        {
          return (this as td.MessageAnimation).caption;
        }
    }
    return null;
  }
}
