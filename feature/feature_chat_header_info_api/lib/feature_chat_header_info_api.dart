library feature_chat_header_info_api;

import 'package:flutter/widgets.dart';

abstract class IChatHeaderInfoFeatureApi {
  IChatHeaderInfoInteractor getChatHeaderInfoInteractor(int chatId);
  IChatHeaderInfoFactory getChatHeaderInfoFactory();
}

abstract class IChatHeaderInfoFactory {
  Widget create({required BuildContext context, required ChatHeaderInfo info});
}

abstract class IChatHeaderInfoInteractor {
  Stream<ChatHeaderInfo> get infoStream;

  ChatHeaderInfo get current;
}

class ChatHeaderInfo {
  ChatHeaderInfo({
    required this.title,
    required this.subtitle,
    required this.photoId,
    required this.chatId,
  });

  final String title;
  final String subtitle;

  final int? photoId;
  final int chatId;
}
